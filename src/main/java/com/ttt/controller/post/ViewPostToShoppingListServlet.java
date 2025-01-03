package com.ttt.controller.post;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.ttt.dto.Cart2;
import com.ttt.dto.Member2;
import com.ttt.dto.Post2;

@WebServlet("/post/toshoppinglist")
public class ViewPostToShoppingListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ViewPostToShoppingListServlet() {
        super();
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();
        
        try {
            // 파라미터 검증
            if(request.getParameter("postNo") == null || request.getParameter("memberNo") == null) {
                throw new IllegalArgumentException("필수 파라미터가 누락되었습니다.");
            }
            
            int postNo = Integer.parseInt(request.getParameter("postNo"));
            int memberNo = Integer.parseInt(request.getParameter("memberNo"));
            
            Post2 post = Post2.builder().postNo(postNo).build();
            Member2 member = Member2.builder().memberNo(memberNo).build();
            
            Cart2 cart = Cart2.builder()
                    .post(post)
                    .member(member)
                    .isPayment(0)  // 초기값 설정
                    .build();
            
            // DB 저장 로직 필요
            int result = cartService.insertCart(cart);
            
            jsonResponse.put("success", result > 0);
            jsonResponse.put("message", result > 0 ? "장바구니에 추가되었습니다." : "장바구니 추가에 실패했습니다.");
            
        } catch(Exception e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "오류가 발생했습니다: " + e.getMessage());
        }
        
        out.print(jsonResponse.toString());
        out.flush();
    }
	}

}
