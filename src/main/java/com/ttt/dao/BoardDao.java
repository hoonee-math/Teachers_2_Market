package com.ttt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Post2;

public class BoardDao {
	public List<Post2> selectPostByCategory(SqlSession session, Map<String, Integer> param) {
		int cPage = param.get("cPage");
		int categoryNo = param.get("categoryNo");
		
		return session.selectList("post2.selectPostByCategory",
				Map.of("categoryNo", categoryNo, "start", (cPage-1)*16+1, "end", cPage*16));
	}

}
