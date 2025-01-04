package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.oreilly.servlet.MultipartRequest;
import com.ttt.dao.PostDao;
import com.ttt.dto.File2;
import com.ttt.dto.Image2;
import com.ttt.dto.Post2;
import com.ttt.util.post.FileUploadUtil;

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
	public int insertPost(Post2 post, MultipartRequest mr, String webAppPath) throws Exception {
		SqlSession session = getSession();
		int result = 0;
		
		try {
			System.out.println("PostService.java 에 post 객체 전달 값: "+post.toString());
			// 1. POST2 테이블 insert
			result = dao.insertPost(session, post);
			if (result <= 0)
				throw new Exception("게시글 등록 실패");
			System.out.println(post.getPostNo());
			// 2. 생성된 postNo 조회
			int postNo = dao.selectLastPostNo(session);
			post.setPostNo(postNo);
			System.out.println("postNo 조회: "+ postNo); //현재 여기서 계속 -1 만 출력되고 있음. selectLastPostNo 이게 실패한 것 같음

			String memberId = post.getMember().getMemberId();

			// 3. 상품/파일 정보 저장
			if (post.getProductType() == 1) { // 상품
				// 3-1. 상품 정보 저장
				// 이미 저장했는데 굳이 안해도 될것 같음 post.getProduct2().setPost(post);
				result = dao.insertProduct(session, post);
				if (result <= 0)
					throw new Exception("상품 정보 등록 실패");

				// 3-2. 상품 이미지 저장
				List<Image2> images = FileUploadUtil.saveImages(mr, webAppPath, memberId, postNo);
				System.out.println("이미지 확인 : "+ images);
				
				for (Image2 img : images) {
					System.out.println("이미지 확인 :"+ img);
					img.setPostNo(postNo);
					result = dao.insertImageByPostNo(session, img);
					if (result <= 0)
						throw new Exception("이미지 등록 실패");
				}

			} else { // 파일
				// 3-3. 파일 정보 저장
				File2 file = FileUploadUtil.saveFile(mr, webAppPath, memberId, postNo);
				if (file != null) {
					file.setPost(post);
					result = dao.insertFile(session, file);
					if (result <= 0)
						throw new Exception("파일 정보 등록 실패");
				}

			    // 3-4. 파일 게시글의 이미지 저장
			    List<Image2> images = FileUploadUtil.saveImages(mr, webAppPath, memberId, postNo);
			    for(Image2 img : images) {
			        img.setPostNo(postNo);
			        result = dao.insertImageByPostNo(session, img);
			        if(result <= 0) throw new Exception("이미지 등록 실패");
			    }
			}

			session.commit();

		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
            // TODO: 파일 삭제 처리 필요
			throw e;
		} finally {
			session.close();
		}
	    
	    return result;
	}
}
