package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.ttt.dao.PostDao;
import com.ttt.dto.File2;
import com.ttt.dto.Image2;
import com.ttt.dto.Post2;
import com.ttt.dto.Product2;

public class PostService {
	private PostDao dao = new PostDao();
	
	//post2 객체불러오기
	public Post2 selectPostByNo(int postNo) {
		SqlSession session = getSession();
		Post2 p = dao.selectPostJoinAll(session, postNo);
		session.close();
		return p;
	}
	//viewpost.jsp에 이미지 불러오기
	public List<Image2> selectImageNo(int postNo) {
		SqlSession session = getSession();
		List<Image2> img = dao.selectImageNo(session, postNo);
		session.close();
		return img;
	}
	
	public int toggleNotifyFix(int postNo) {
		SqlSession session = getSession();
	    int result = 0;
	    try {
	        result = dao.toggleNotifyFix(session, postNo);
	        if(result > 0) session.commit();
	        else session.rollback();
	    } catch(Exception e) {
	        session.rollback();
	        throw e;
	    } finally {
	        session.close();
	    }
	    return result;
	}
	
	//post2 객체불러오기
	public Post2 selectPostByNoOnAdminMenu(int postNo) {
		SqlSession session = getSession();
		return dao.selectPostByNoOnAdminMenu(session, postNo);
	}

	// 상품/파일 등록 게시글을 작성한 경우 하나의 트랜잭션에서 처리하는 insert 서비스
	public int insertPost(JsonObject jsonData) throws Exception {
		SqlSession session = getSession();
		int result = 0;

		try {
			// 1. Post2 데이터 준비
			Post2 post = Post2.builder()
					.postTitle(jsonData.get("postTitle").getAsString())
					.postContent(jsonData.get("postContent").getAsString())
					.isTemp(jsonData.get("isTemp").getAsInt())
					.categoryNo(jsonData.get("categoryNo").getAsInt())
					.subjectNo(jsonData.get("subjectNo").getAsInt())
					.productType(jsonData.get("productType").getAsInt())
					.build();

			// 2. POST2 테이블 insert
			result = dao.insertPost(session, post);
			if (result <= 0)
				throw new Exception("게시글 등록 실패");

			// 방금 입력된 post_no 조회
			int postNo = dao.selectLastPostNo(session);
			post.setPostNo(postNo);

			// 3. 상품/파일 정보 저장
			if (post.getProductType() == 1) { // 상품
				JsonObject productData = jsonData.getAsJsonObject("product");
				Product2 product = Product2.builder()
						.post(post)
						.isFree(productData.get("isFree").getAsInt())
						.productPrice(productData.get("productPrice").getAsInt())
						.hasDeliveryFee(productData.get("hasDeliveryFee").getAsInt())
						.deliveryFee(productData.get("deliveryFee").getAsInt())
						.stockCount(productData.get("stockCount").getAsInt())
						.build();

				result = dao.insertProduct(session, product);
				if (result <= 0)
					throw new Exception("상품 정보 등록 실패");

			} else { // 파일
				JsonObject fileData = jsonData.getAsJsonObject("file");
				File2 file = File2.builder()
						.post(post)
						.isFree(fileData.get("isFree").getAsInt())
						.filePrice(fileData.get("filePrice").getAsInt())
						.salePeriod(LocalDate.parse(fileData.get("salePeriod").getAsString()))
						.build();

				result = dao.insertFile(session, file);
				if (result <= 0)
					throw new Exception("파일 정보 등록 실패");
			}

			// 4. 이미지 정보 저장
			if (jsonData.has("images")) {
				JsonArray images = jsonData.getAsJsonArray("images");
				for (JsonElement img : images) {
					JsonObject imgObj = img.getAsJsonObject();
					// postNo 값을 담아서 전달
					Image2 image = Image2.builder()
							.postNo(postNo)
							.imgSeq(imgObj.get("imgSeq").getAsInt())
							.oriname(imgObj.get("oriname").getAsString())
							.renamed(imgObj.get("renamed").getAsString())
							.build();

					result = dao.insertImageByPostNo(session, image);
					if (result <= 0)
						throw new Exception("이미지 정보 등록 실패");
				}
			}

			session.commit();

		} catch (Exception e) {
			session.rollback();
			throw e;
		} finally {
			session.close();
		}
	    
	    return result;
	}
}
