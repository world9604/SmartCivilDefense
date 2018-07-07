package com.civildefense.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.w3c.dom.views.AbstractView;

@Repository("excelDao")
public class ExcelDao extends AbstractDAO{
 
    @Autowired
    private SqlSession sqlSession;
 
    public void setSqlSession(SqlSession sqlSession){
        this.sqlSession = sqlSession;
    }
 
    public List<Object> getAttendances(Map<String, Object> searchMap){
        return sqlSession.selectList("selectAttendance", searchMap);
    }
 
}