package com.ttt.controller.post;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.google.gson.Gson;
import com.ttt.common.SqlSessionTemplate;

/**
 * Servlet implementation class DistrictServlet
 */
@WebServlet("/post/district")
public class DistrictServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DistrictServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String region = request.getParameter("region");
		List<String> districts = new ArrayList<>();
		
		try {
			SqlSession session = SqlSessionTemplate.getSession();
			districts = session.selectList("post2.selectDistrict",region);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		response.setContentType("application/json;charset=UTF-8");
		new Gson().toJson(districts, response.getWriter());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
