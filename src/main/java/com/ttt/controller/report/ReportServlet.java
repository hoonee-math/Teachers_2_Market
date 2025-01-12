package com.ttt.controller.report;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import oracle.jdbc.proxy.annotation.Post;

@WebServlet("/report/*")
public class ReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ReportServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uri = request.getRequestURI();
        String path = uri.substring(request.getContextPath().length());

        switch(path) {
            case "/report/form":
                // 신고 폼 화면 표시
				/*
				 * int postNo = Integer.parseInt(request.getParameter("postNo")); Post post =
				 * postService.selectPostByNo(postNo); request.setAttribute("post", post);
				 */
                
                request.getRequestDispatcher("/WEB-INF/views/report/reportForm.jsp").forward(request, response);
                break;
        }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uri = request.getRequestURI(); // /market/report/submit
        String path = uri.substring(request.getContextPath().length()); // /report/submit

        if("/report/submit".equals(path)) {
            // POST 요청 처리 - JSON 응답 설정
            response.setContentType("application/json;charset=UTF-8");
            PrintWriter out = response.getWriter();
            JSONObject jsonResponse = new JSONObject();
            System.out.println("신고처리 report 서비스 start");
            try {
                // 신고 데이터 받아오기
				/*
				 * Report report = new Report();
				 * report.setPostNo(Integer.parseInt(request.getParameter("postNo")));
				 * report.setReportedNo(Integer.parseInt(request.getParameter("reportedNo")));
				 * report.setAuthorNo(Integer.parseInt(request.getParameter("authorNo")));
				 * report.setReportTypeNo(Integer.parseInt(request.getParameter("reportTypeNo"))
				 * ); report.setReportContent(request.getParameter("reportContent"));
				 */
                
                // 서비스 호출하여 신고 저장
				int result = 1; /* reportService.insertReport(report); */
                
                if(result > 0) {
                    jsonResponse.put("success", true);
                } else {
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "신고 접수에 실패했습니다.");
                }
                
            } catch(Exception e) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", e.getMessage());
            }
            
            out.print(jsonResponse.toString());
            out.flush();
        }
    
	}

}
