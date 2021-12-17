//
//  SqlOperator.swift
//  Airplane-Test
//
//  Created by 张维熙 on 2021/12/11.
//

import Foundation

class SqlOperator
{
    static func initDB()
    {
        // 引用SQLiteManager的单例对象
        let sqlite = SQLiteManager.shareInstance
        
        // 没打开则返回
        if !sqlite.openDB()
        {
            return
        }
        
        // 创建表
        let createSql = "CREATE TABLE IF NOT EXISTS record('id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT," + "'score' INTEGER, 'time' TEXT);"
        if !sqlite.execNoneQuerySQL(sql: createSql) // 如果不成功，则关闭数据库并返回。
        {
            sqlite.closeDB()
            return
        }
        
        // 清除表
        let cleanAllRec = "DELETE FROM record;"
        if !sqlite.execNoneQuerySQL(sql: cleanAllRec)
        {
            sqlite.closeDB()
            return
        }
        
        // 重置表
        let resetRec = "DELETE FROM sqlite_sequence WHERE name = 'record';"
        if !sqlite.execNoneQuerySQL(sql: resetRec)
        {
            sqlite.closeDB()
            return
        }
        
        // 插入测试数据
        let rec0 = "INSERT INTO record(score,time) VALUES('0','2021-12-1 00:00:00 +0000');"
        let rec1 = "INSERT INTO record(score,time) VALUES('0','2021-12-1 00:00:00 +0000');"
        let rec2 = "INSERT INTO record(score,time) VALUES('0','2021-12-1 00:00:00 +0000');"
        if !sqlite.execNoneQuerySQL(sql: rec0)
        {
            sqlite.closeDB()
            return
        }
        if !sqlite.execNoneQuerySQL(sql: rec1)
        {
            sqlite.closeDB()
            return
        }
        if !sqlite.execNoneQuerySQL(sql: rec2)
        {
            sqlite.closeDB()
            return
        }
        
        // 关闭数据库
        sqlite.closeDB()
    }
    
    static func insertRecord(_ score: Int) {
        let sqlite = SQLiteManager.shareInstance
        
        // 打开数据库
        if !sqlite.openDB() { return }
        
        // 插入数据
        let date = Date()
        let record = "INSERT INTO record(score,time) VALUES('\(score)','\(date)');"
        if !sqlite.execNoneQuerySQL(sql: record)
        {
            sqlite.closeDB()
            return
        }
        
        // 关闭数据库
        sqlite.closeDB()
    }
    
    static func getRecord() -> [[String: AnyObject]]
    {
        // 获取SQLiteManager的单例对象
        let sqlite = SQLiteManager.shareInstance
        var queryResult: [[String: AnyObject]]? = nil
        
        // 打开数据库
        if !sqlite.openDB() { return queryResult! }
        
        // 查询所有
        queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM record ORDER BY score DESC;")
        
        print(queryResult!)
        
        for row in queryResult!
        {
            print(row["score"]!)
        }
        
        // 关闭数据库
        sqlite.closeDB()
        
        return queryResult!
    }
    
    static func GetID1() -> [AnyObject]
    {
        var info: [AnyObject] = []
        // 获取SQLiteManager的单例对象
        let sqlite = SQLiteManager.shareInstance
        
        // 打开数据库
        if !sqlite.openDB() { return info }
        
        // 查询所有
        let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM record WHERE id=1;")
        
        print(queryResult!)
        
        for row in queryResult!
        {
            info.append(row["id"]!)
            info.append(row["score"]!)
            info.append(row["time"]!)
        }
        
        // 关闭数据库
        sqlite.closeDB()
        
        return info
    }
}
