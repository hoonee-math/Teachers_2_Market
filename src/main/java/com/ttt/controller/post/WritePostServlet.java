package com.ttt.controller.post;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.ttt.dto.File2;
import com.ttt.dto.Image2;
import com.ttt.dto.Member2;
import com.ttt.dto.Post2;
import com.ttt.dto.Product2;
import com.ttt.service.PostService;
@WebServlet(name="writePost", urlPatterns="/post/write/*")
public class WritePostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public WritePostServlet() {
		super();
	}

	// "/post/report/form"으로 들어오는 요청에 대해 게시글 등록 페이지 열어주기
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("writePostServlet 도착");
		String uri = request.getRequestURI();
		String path = uri.substring(request.getContextPath().length());

		switch (path) {
		case "/post/write/form":
			System.out.println("writePostServlet /post/write/form 으로 맵핑 완료");
			request.getRequestDispatcher("/WEB-INF/views/post/writepost.jsp").forward(request, response);
			break;
		default:
			request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
		}
	}

	// "/post/report/submit"으로 들어오는 요청에 게시글 등록 로직 실행시키기
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getRequestURI();
		String path = uri.substring(request.getContextPath().length());

		if (!path.equals("/post/write/submit")) {
			/* 잘못된 접근인 경우 */
			request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
		} else {
			/* 요청 주소 path 값이 /post/write/submit 가 맞는 경우 */

			request.setCharacterEncoding("UTF-8");
			// 응답 설정
			response.setContentType("application/json;charset=utf-8");
			PrintWriter out = response.getWriter();

			// 결과 데이터를 담을 Map
			Map<String, Object> responseData = new HashMap<>();

			try {
				// 1. 로그인 체크 (확인)
				Member2 loginMember = (Member2) request.getSession().getAttribute("loginMember");
				if (loginMember == null) {
					throw new RuntimeException("로그인이 필요한 서비스입니다.");
				}

				// 2. 파일 저장 경로 설정
				// 방법 2: ClassLoader 사용 -- 임시방편
				String webAppPath = new File(Thread.currentThread().getContextClassLoader().getResource("").getPath()
						.replace("target/classes/", "src/main/webapp/")).getAbsolutePath();
				
				String uploadPath=request.getServletContext().getRealPath("/resources/images/upload/");
				
				// 2. 디렉토리 존재 여부 확인 및 생성
				File directory = new File(uploadPath);
				
				if (!directory.exists()) {
					boolean created = directory.mkdirs();
					if (!created) {
						// 디렉토리 생성 실패 시 로그 출력 또는 예외 처리
						System.out.println("디렉토리 생성 실패: " + uploadPath);
					}
				}
				// 3. MultipartRequest 생성
				MultipartRequest mr = new MultipartRequest(request, uploadPath, 1024 * 1024 * 100, // 100MB
						"UTF-8", new DefaultFileRenamePolicy());

				// 4. Post2 객체 생성
				Post2 post = Post2.builder().postTitle(mr.getParameter("postTitle"))
					.postContent(mr.getParameter("postContent"))
					.categoryNo(Integer.parseInt(mr.getParameter("categoryNo")))
					.subjectNo(Integer.parseInt(mr.getParameter("subjectNo")))
					.productType(Integer.parseInt(mr.getParameter("productType")))
					.isTemp(Integer.parseInt(mr.getParameter("isTemp")))
					.member(loginMember)
					.build();

				// 5. 상품/파일 정보 생성
				if ("1".equals(mr.getParameter("productType"))) { // 상품
					Product2 product = Product2.builder()
						.isFree(Integer.parseInt(mr.getParameter("isFree")))
						.productPrice(Integer.parseInt(mr.getParameter("productPrice")))
						.hasDeliveryFee(Integer.parseInt(mr.getParameter("hasDeliveryFee")))
						.deliveryFee(Integer.parseInt(mr.getParameter("deliveryFee")))
						.stockCount(Integer.parseInt(mr.getParameter("stockCount")))
						.build();
					post.setProduct2(product);

					// 상품 이미지 파일 처리
					List<Image2> images = new ArrayList<>();
					Enumeration<String> files = mr.getFileNames();
					while (files.hasMoreElements()) {
						String fileName = files.nextElement();
						if (fileName.startsWith("upfile")) { // 상품 이미지 파일
							String oriname = mr.getOriginalFileName(fileName);
							String renamed = mr.getFilesystemName(fileName);
							if (oriname != null) {
								Image2 img = Image2.builder()
									.oriname(oriname)
									.renamed(renamed)
									.imgSeq(images.size() + 1) // 순차적으로 번호 부여
									.build();
								images.add(img);
							}
						}
					}
					post.setPostImg(images);

				} else { // 파일
					String oriname = mr.getOriginalFileName("uploadFile0"); // 첫 번째 파일만 처리
					String renamed = mr.getFilesystemName("uploadFile0");

					if (oriname != null) {
						File2 file = File2.builder()
							.isFree(Integer.parseInt(mr.getParameter("isFree")))
							.filePrice(Integer.parseInt(mr.getParameter("filePrice")))
							.salePeriod(LocalDate.parse(mr.getParameter("salePeriod")))
							.oriname(oriname)
							.renamed(renamed)
							.build();
						post.setFile2(file);
					}

					// 상품 이미지 파일 처리
					List<Image2> images = new ArrayList<>();
					Enumeration<String> files = mr.getFileNames();
					while (files.hasMoreElements()) {
						String fileName = files.nextElement();
						if (fileName.startsWith("upfile")) { // 상품 이미지 파일
							oriname = mr.getOriginalFileName(fileName);
							renamed = mr.getFilesystemName(fileName);
							
					        // 실제 파일 존재 여부 확인
					        File uploadedFile = new File(uploadPath + renamed);
							if (oriname != null) {
								Image2 img = Image2.builder()
									.oriname(oriname)
									.renamed(renamed)
									.imgSeq(images.size() + 1) // 순차적으로 번호 부여
									.build();
								images.add(img);
							}
						}
					}
					post.setPostImg(images);
				}
				// 트랜잭션 처리
				System.out.println("post등록을 시작합니다.");
				PostService service = new PostService();
				int result = service.insertPost(post, mr, uploadPath);

				if (result > 0) {
					responseData.put("success", true);
					responseData.put("message", "게시글이 등록되었습니다.");
					responseData.put("postNo", post.getPostNo());
				} else {
					throw new RuntimeException("게시글 등록에 실패했습니다.");
				}

			} catch (Exception e) {
				e.printStackTrace();
				responseData.put("success", false);
				responseData.put("message", e.getMessage());
			}

			// JSON 응답 전송
			new Gson().toJson(responseData, out);

		}
	}

}
