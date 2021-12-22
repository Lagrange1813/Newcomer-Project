//
//  SQLiteManager.swift
//  Airplane-Test
//
//  Created by 张维熙 on 2021/12/11.
//

import Foundation

class SQLiteManager: NSObject {
    private var dbPath: String! // 数据库所存储的文件所在路径
    private var database: OpaquePointer? // 数据库，是一个指针，指向一个结构体
    
    // 共享一个实例化对象 —————— 单例变量
    static var shareInstance: SQLiteManager {
        return SQLiteManager()
    }
    
    override init() {
        let dirpath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        dbPath = dirpath.appendingPathComponent("app.sqlite").path
    }
    
    // 打开数据库
    func openDB()->Bool {
        let result = sqlite3_open(dbPath, &database)
        if result != SQLITE_OK {
            print("打开数据库失败")
            return false
        }
        return true
    }
    
    // 关闭数据库
    func closeDB() {
        sqlite3_close(database)
    }
    
    /**
            执行数据库语句
            1. 创建 create
            2. 插入 insert
            3. 更新 update
            4. 删除 delete
     */
    func execNoneQuerySQL(sql: String)->Bool {
        var errMsg: UnsafeMutablePointer<Int8>? // 错误信息的指针（不安全、可修改）
        let cSql = sql.cString(using: String.Encoding.utf8)! // 给sql语句进行编码
        
        /**
            参数说明：
                1. 已打开的数据库句柄
                2. 执行的sql语句
                3. 回调函数
                4. 自定义指针，会传递到回调函数内
                5. 错误信息指针
         */
        // 执行成功
        if sqlite3_exec(database, cSql, nil, nil, &errMsg) == SQLITE_OK {
            return true
        }
        
        // 执行不成功
        let msg = String(cString: errMsg!)
        print(msg)
        return false
    }
    
    /**
            执行数据库语句
                1. 查询
     */
    func execQuerySQL(sql: String)->[[String: AnyObject]]? {
        let cSql = sql.cString(using: String.Encoding.utf8)! // 对sql语句进行utf8编码
        var statement: OpaquePointer? // 语句的指针
        
        /**
                参数说明：
                    1. 已打开的数据库句柄
                    2. 执行的sql语句
                    3. 以字节为单位的sql语句长度，-1表示自动计算
                    4. 语句句柄，据此获取查询结果，需要调用 sqlite3_finalize 释放
                    5. 未使用的指针地址，通常传入nil
         */
        // 执行不成功
        if sqlite3_prepare_v2(database, cSql, -1, &statement, nil) != SQLITE_OK {
            sqlite3_finalize(statement)
            
            print("执行 \(sql) 错误")
            let errmsg = sqlite3_errmsg(database)
            if errmsg != nil {
                print(errmsg!)
            }
            
            return nil
        }
        
        // 成功：需要从 statement 里面取数据，定义 rows 变量来接收数据
        var rows = [[String: AnyObject]]()
        
        // 每次取 1 行
        while sqlite3_step(statement) == SQLITE_ROW {
            rows.append(record(stmt: statement!))
        }
        
        // 最后释放空间
        sqlite3_finalize(statement)
        
        // 返回结果
        return rows
    }
    
    // 读一行记录一行
    private func record(stmt: OpaquePointer)->[String: AnyObject] {
        var row = [String: AnyObject]()
        
        // 遍历所有列，获取每一列的信息
        for col in 0 ..< sqlite3_column_count(stmt) {
            let cName = sqlite3_column_name(stmt, col) // 获取列名
            let name = String(cString: cName!, encoding: String.Encoding.utf8)
            
            var value: AnyObject?
            
            switch sqlite3_column_type(stmt, col) {
            case SQLITE_FLOAT:
                value = sqlite3_column_double(stmt, col) as AnyObject
            case SQLITE_INTEGER:
                value = Int(sqlite3_column_int(stmt, col)) as AnyObject
            case SQLITE_TEXT:
                let cText = sqlite3_column_text(stmt, col)
                value = String(cString: cText!) as AnyObject
            case SQLITE_NULL:
                value = NSNull()
            default:
                print("不支持的数据类型")
            }
            row[name!] = value ?? NSNull()
        }
        
        return row
    }
}
