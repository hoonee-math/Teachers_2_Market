package com.ttt.controller.post;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/post/viewpost")
public class ViewPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ViewPostServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 상품 이미지 더미데이터
        List<Map<String, String>> images = new ArrayList<>();
        for(int i=1; i<=3; i++) {
            Map<String, String> img = new HashMap<>();
            img.put("imgNo", String.valueOf(i));
            img.put("oriname", "product" + i + ".jpg");
            img.put("rename", "iqpuzzlelamp"+i+".png");
            images.add(img);
        }
        request.setAttribute("images", images);
        
        // 판매자 정보 더미데이터
        request.setAttribute("memberName", "수학의정석");
        request.setAttribute("sellerRating", "4.8");
        
        // 상품 정보 더미데이터
        request.setAttribute("postTitle", "2024 수학 교과서 풀이노트 판매합니다");
        request.setAttribute("productPrice", 30000);
        request.setAttribute("stockCount", 5);
        request.setAttribute("isFree", 0);
        request.setAttribute("hasDeliveryFee", 1);
        request.setAttribute("deliveryFee", 3000);
        request.setAttribute("postContent", "2024년도 고등학교 수학 교과서 풀이노트입니다.<br>모든 문제 완벽 풀이!<br>총 200페이지 분량입니다.");
        
        // 상품문의 더미데이터
        List<Map<String, String>> qnaList = new ArrayList<>();
        for(int i=1; i<=3; i++) {
            Map<String, String> qna = new HashMap<>();
            qna.put("qnaTitle", "문의드립니다" + i);
            qna.put("qnaContent", "현재 재고가 얼마나 남았나요?" + i);
            qna.put("answerContent", "현재 5권 남았습니다!" + i);
            qna.put("answerDate", "2024-0" + i + "-15");
            qnaList.add(qna);
        }
        request.setAttribute("qnaList", qnaList);
        
        // 상품후기 더미데이터
        List<Map<String, String>> reviewList = new ArrayList<>();
        for(int i=1; i<=3; i++) {
            Map<String, String> review = new HashMap<>();
            review.put("reviewNo", String.valueOf(i));
            review.put("rating", String.valueOf(5.0 - (i * 0.5))); // 4.5, 4.0, 3.5
            review.put("reviewDate", "2024-0" + i + "-10");
            review.put("reviewContent", "정말 좋은 교재입니다! 추천합니다" + i);
            review.put("reviewImg", "logo(NoBackGroun).png");
            review.put("reviewLikeCount", String.valueOf(10 * i));
            reviewList.add(review);
        }
        request.setAttribute("reviewList", reviewList);
		
		request.getRequestDispatcher("/WEB-INF/views/post/viewpost.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
