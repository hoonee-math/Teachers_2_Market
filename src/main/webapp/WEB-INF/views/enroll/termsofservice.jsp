<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="icon" href="${path }/resources/images/favicon.jpeg">
	<title>티꿀모아</title>
	
    <!-- 2. 외부 CSS 파일들 -->
    <!-- 2-1. Bootstrap CSS (다른 CSS보다 먼저) -->
    <!-- 2-2. Bootstrap Icons (필요한 경우) -->
    <!-- 2-3. 직접 제작한 CSS 파일들 (Bootstrap CSS 보다 아래 위치시켜야 함) -->
	<link rel="stylesheet" href="${path }/resources/css/common/layout.css">
	<link rel="stylesheet" href="${path }/resources/css/common/footer.css">
    <!-- 3. 컴포넌트 CSS (각 요소) -->
    <!-- 4. 페이지별 CSS -->
    <!-- 5. 외부 라이브러리 ex: jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <!-- 6. Bootstrap JS (jQuery 다음, 내부 스타일 전에) 또는 외부 라이브러리 -->
    <!-- 7. 내부 style 태그 -->
    <style>
    body {
    	background-color : #fffadd;
    	background : linear-gradient(to right, #fffadd, #ffffff);
    	margin: 0;
    }
    #logincheck-main-container {
		display : flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		height: 970px;
		padding: 20px;
	}
	.main-content {
		margin-top:0px;
		background: #fff;
	    padding: 0px 30px;
	    border-radius: 30px;
	    box-shadow: 0 8px 12px rgba(0, 0, 0, 0.3);
	    width: 550px;
	    height : 450px;
	    text-align: center;
	}
	#login-font {
		font-family:Sans-serif;
		font-size: 40px;
		color : grey;
	}
	#check-line, #check-line1, #check-line2, #check-line3  {
		margin-top:10px;
		display:flex;
	}
	#check-content, #check-content2, #check-content3 {
		display:flex;
		justify-content:center;
	}
	#check-contentbox, #check-contentbox2, #check-contentbox3 {
		overflow:auto;
		max-width: 500px;
	    color: #6f6f6f;
	    font-size: 12px;
		max-height : 130px;
		border : 1px solid grey;
		white-space: pre-line;;
		border-radius : 3px;
	}
	#login-next {
		margin-top : 30px;
		background-color : #fffadd;
		color : #cccccc;
		border:none;
		padding:12px;
		width: 90px;
	}
	.login-mustcheck {
		color : red;
	}
	.main-section {
		display: flex;
		flex-direction: column;
	}
	#agree-button {
		display: flex;
		justify-content: center;
		margin-top: 20px;
		padding: 20px;
		gap: 30px;
	}
	#logincheck-inner-header {
		display:flex;
		justify-content: center;
		align-items:center;
		gap:30px;
	}
	#join {
	    cursor: pointer;
	    height: 50px;
	    background-color: #fffadd;
	    border: none;
	    padding: 10px 20px;
	    font-size: 16px;
	    color: #222;
	    border-radius: 5px;
	}
	#cancle {
		cursor: pointer;
	    height: 50px;
	    background-color: #grey;
	    border: none;
	    padding: 10px 20px;
	    font-size: 16px;
	    border-radius: 5px;
	}
	#cancle:hover {
		background-color: #cccccc;
	}

	#join:hover {
	    background-color: #fff6c2;
	}
	.agreetext {
		color:#6f6f6f;
	}
    </style>
</head>
<body>
<!-- 콘텐츠 영역 -->
<div id="wrap">
<!-- 메인 콘텐츠 -->
<main class="main">
	<div id="logincheck-main-container">
		<!-- 콘텐츠 영역 -->
		<div class="main-content">
			<section class="row main-section">
				<!-- 섹션 1 -->
				<div id="logincheck-inner-container">
					<div id="logincheck-inner-header">
						<img class="logo-container" src="${path}/resources/images/favicon.jpeg" style="width:60px; height:60px; border-radius:10px;">
						<p id="login-font">회원 동의 약관</p>
						<img class="logo-container" src="${path}/resources/images/favicon.jpeg" style="width:60px; height:60px; border-radius:10px;">
					</div>
					<form id="logincheck-frm" action="${path}/member/enrollmain" method="post">
					<div id=check-line>
						<p class="agreetext">19세 이상 인가요?</p><p class="login-mustcheck">(필수)</p>
						<input type="checkbox" name="sign" required>
					</div>
					<div id="check-line1">
						<p class="agreetext">이용약관 동의</p><p class="login-mustcheck">(필수)</p>
						<input type="checkbox" name="sign2" required>
					</div>
					<div id="check-content">
						<div id="check-contentbox">
							<p>
							티꿀모아 중고거래 사이트 이용약관
							
제1조 (용도)
본 약관은 티꿀모아(이하 “회사”)가 제공하는 중고거래 서비스(이하 “서비스”)의 이용 조건 및 절차, 회원과 회사의 권리, 권리, 책임 및 기타 필요한 사항을 말합니다. 규정을 목적으로 합니다.

제2조 (정의)

"서비스"란 회사가 임대 관련 서비스를 제공하는 웹사이트 및 모바일 거래를 말합니다.
"회원"이란 본 약관에 따라 회사와 이용 계약을 보호하고 서비스를 이용하는 것을 말합니다.
"콘텐츠"란 회원이 서비스에 등록한 글, 이미지, 동영상 등 모든 자료를 의미합니다.
제3조 (약관의 고객 및 변경)

본 약관은 서비스를 이용하고자 하는 모든 회원에게 불만을 발생시킵니다.
회사는 관련 활동을 위배하지 않는 범위에서 약관을 보호할 수 있는지 확인하고, 변경된 약관은 공지사항을 통해 회원에게 공지됩니다.
제4조 (회원가입 및 독립)

회원가입은 서비스를 통해 제공되는 양식에 따라 정보를 입력하고 약관에 동의하도록 합니다.
회원은 회원 가입 내 설정을 독립적으로 표시할 수 있으며, 회사는 신속히 처리합니다.
제5조 (서비스 이용)

회원은 본 서비스를 통해 중고 물품 거래할 수 있는지 확인하고, 회사는 거래의 중개 및 관련 부가 서비스를 제공합니다.
회원은 여전히 ​​정보를 제공해야 하며, 허위 정보 제공으로 사기 문제에 대한 책임은 회원 본인에게 있습니다.
제6조 (회원의 허락)

회원은 서비스 이용과 관련하여 다음 서비스를 이용하시기 바랍니다.
허위 정보 등록
교류의 권리를 존중하는 것
홍보 및 공공질서에 대한 조치
회원은 회사의 운영 정책 및 관련 홍보를 준수해야 합니다.
제7조 (회사의 권리 및 증명장부)

회사는 회원 간 거래 과정에서 손해 문제에 대해 책임을 지지합니다.
회사는 혼성지변, 시스템 장애를 가능하게 하는 힘이 있는 영역으로 서비스를 제공할 수 없는 경우 책임을 면합니다.
제8조(개인정보 보호)
회사는 회원의 개인정보를 보호하기 위해 관련 보호 및 개인정보 처리방침을 준수합니다.

제9조 (서비스 중단 및 종료)

회사는 운영상 필요에 따라 서비스의 전체적으로 또는 일부를 중단하거나 종료할 수 있습니다.
서비스 중단 시 회사는 사전에 이를 공지하며, 회원은 중단 시 발생하는 바다에 대해 보상받을 수 없습니다.
제10조 (준거법 및 독립)
본 약관과 관련 모든 당사자는 대한민국 절차에 따라 처리하며, 본인은 회사의 신뢰를 존중합니다.

부칙
본 약관은 2024년 12월 27일부터 검색됩니다.
							</p>
						</div>
					</div>	
					<div id="check-line2">
						<p class="agreetext">개인정보 처리방침 동의</p><p class="login-mustcheck">(필수)</p>
						<input type="checkbox" name="sign3" required>
					</div>
					<div id="check-content2">
						<div id="check-contentbox2">
							<p>
개인정보처리방침

[차례]
1. 총칙
2. 개인정보 수집에 대한 동의
3. 개인정보의 수집 및 이용목적
4. 수집하는 개인정보 항목
5. 개인정보 자동수집 장치의 설치, 운영 및 그 거부에 관한 사항
6. 목적 외 사용 및 제3자에 대한 제공
7. 개인정보의 열람 및 정정
8. 개인정보 수집, 이용, 제공에 대한 동의철회
9. 개인정보의 보유 및 이용기간
10. 개인정보의 파기절차 및 방법
11. 아동의 개인정보 보호
12. 개인정보 보호를 위한 기술적 대책
13. 개인정보의 위탁처리
14. 의겸수렴 및 불만처리
15. 부 칙(시행일) 

1. 총칙

본 업체 사이트는 회원의 개인정보보호를 소중하게 생각하고, 회원의 개인정보를 보호하기 위하여 항상 최선을 다해 노력하고 있습니다. 
1) 회사는 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」을 비롯한 모든 개인정보보호 관련 법률규정을 준수하고 있으며, 관련 법령에 의거한 개인정보처리방침을 정하여 이용자 권익 보호에 최선을 다하고 있습니다.
2) 회사는 「개인정보처리방침」을 제정하여 이를 준수하고 있으며, 이를 인터넷사이트 및 모바일 어플리케이션에 공개하여 이용자가 언제나 용이하게 열람할 수 있도록 하고 있습니다.
3) 회사는 「개인정보처리방침」을 통하여 귀하께서 제공하시는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다.
4) 회사는 「개인정보처리방침」을 홈페이지 첫 화면 하단에 공개함으로써 귀하께서 언제나 용이하게 보실 수 있도록 조치하고 있습니다.
5) 회사는  「개인정보처리방침」을 개정하는 경우 웹사이트 공지사항(또는 개별공지)을 통하여 공지할 것입니다.

2. 개인정보 수집에 대한 동의

귀하께서 본 사이트의 개인정보보호방침 또는 이용약관의 내용에 대해 「동의 한다」버튼 또는 「동의하지 않는다」버튼을 클릭할 수 있는 절차를 마련하여, 「동의 한다」버튼을 클릭하면 개인정보 수집에 대해 동의한 것으로 봅니다.

3. 개인정보의 수집 및 이용목적

본 사이트는 다음과 같은 목적을 위하여 개인정보를 수집하고 있습니다.
서비스 제공을 위한 계약의 성립 : 본인식별 및 본인의사 확인 등
서비스의 이행 : 상품배송 및 대금결제
회원 관리 : 회원제 서비스 이용에 따른 본인확인, 개인 식별, 연령확인, 불만처리 등 민원처리
기타 새로운 서비스, 신상품이나 이벤트 정보 안내
단, 이용자의 기본적 인권 침해의 우려가 있는 민감한 개인정보(인종 및 민족, 사상 및 신조, 출신지 및 본적지, 정치적 성향 및 범죄기록, 건강상태 등)는 수집하지 않습니다.

4. 수집하는 개인정보 항목

본 사이트는 회원가입, 상담, 서비스 신청 등을 위해 아래와 같은 개인정보를 수집하고 있습니다. 
1) 개인정보 수집방법 : 홈페이지(회원가입)
2) 수집항목 : 이름 , 생년월일 , 성별 , 로그인ID , 비밀번호 , 전화번호 , 주소 , 휴대전화번호 , 이메일 , 주민등록번호 , 접속 로그 , 접속 IP 정보 , 결제기록


5. 개인정보 자동수집 장치의 설치, 운영 및 그 거부에 관한 사항

본 사이트는 귀하에 대한 정보를 저장하고 수시로 찾아내는 '쿠키(cookie)'를 사용합니다. 쿠키는 웹사이트가 귀하의 컴퓨터 브라우저(넷스케이프, 인터넷 익스플로러 등)로 전송하는 소량의 정보입니다. 귀하께서 웹사이트에 접속을 하면 본 사이트의 컴퓨터는 귀하의 브라우저에 있는 쿠키의 내용을 읽고, 귀하의 추가정보를 귀하의 컴퓨터에서 찾아 접속에 따른 성명 등의 추가 입력 없이 서비스를 제공할 수 있습니다.
1) 쿠키는 귀하의 컴퓨터는 식별하지만 귀하를 개인적으로 식별하지는 않습니다. 또한 귀하는 쿠키에 대한 선택권이 있습니다. 웹브라우저의 옵션을 조정함으로써 모든 쿠키를 다 받아들이거나, 쿠키가 설치될 때 통지를 보내도록 하거나, 아니면 모든 쿠키를 거부할 수 있는 선택권을 가질 수 있습니다.
2) 쿠키 등 사용 목적 : 이용자의 접속 빈도나 방문 시간 등을 분석, 이용자의 취향과 관심분야를 파악 및 자취 추적, 각종 이벤트 참여 정도 및 방문 회수 파악 등을 통한 타겟 마케팅 및 개인 맞춤 서비스 제공
3) 쿠키 설정 거부 방법 : 쿠키 설정을 거부하는 방법으로는 귀하가 사용하는 웹 브라우저의 옵션을 선택함으로써 모든 쿠키를 허용하거나 쿠키를 저장할 때마다 확인을 거치거나, 모든 쿠키의 저장을 거부할 수 있습니다. 설정방법 예시 : 인터넷 익스플로어의 경우 → 웹 브라우저 상단의 도구 > 인터넷 옵션 > 개인정보
단, 귀하께서 쿠키 설치를 거부하였을 경우 서비스 제공에 어려움이 있을 수 있습니다.

6 목적 외 사용 및 제3자에 대한 제공

본 사이트는 귀하의 개인정보를 "개인정보의 수집목적 및 이용목적"에서 고지한 범위 내에서 사용하며, 동 범위를 초과하여 이용하거나 타인 또는 타 기업·기관에 제공하지 않습니다.
그러나 보다 나은 서비스 제공을 위하여 귀하의 개인정보를 업체 자회사 또는 제휴사에게 제공하거나, 업체 자회사 또는 제휴사와 공유할 수 있습니다. 개인정보를 제공하거나 공유할 경우에는 사전에 귀하께 업체 자회사 그리고 제휴사가 누구인지, 제공 또는 공유되는 개인정보항목이 무엇인지, 왜 그러한 개인정보가 제공되거나 공유되어야 하는지, 그리고 언제까지 어떻게 보호·관리되는지에 대해 개별적으로 전자우편 및 서면을 통해 고지하여 동의를 구하는 절차를 거치게 되며, 귀하께서 동의하지 않는 경우에는 업체 자회사 그리고 제휴사에게 제공하거나 공유하지 않습니다. 또한 이용자의 개인정보를 원칙적으로 외부에 제공하지 않으나, 아래의 경우에는 예외로 합니다.
1) 이용자들이 사전에 동의한 경우
2) 법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우

7. 개인정보의 열람 및 정정

귀하는 언제든지 등록되어 있는 귀하의 개인정보를 열람하거나 정정하실 수 있습니다. 개인정보 열람 및 정정을 하고자 할 경우에는 "회원정보수정"을 클릭하여 직접 열람 또는 정정하거나, 개인정보 최고관리책임자에게 E-mail로 연락하시면 조치하겠습니다.
귀하가 개인정보의 오류에 대한 정정을 요청한 경우, 정정을 완료하기 전까지 당해 개인정보를 이용하지 않습니다.

8. 개인정보 수집, 이용, 제공에 대한 동의철회

회원가입 등을 통해 개인정보의 수집, 이용, 제공에 대해 귀하께서 동의하신 내용을 귀하는 언제든지 철회하실 수 있습니다. 동의철회는 "마이페이지"의 "회원탈퇴(동의철회)"를 클릭하거나 개인정보관리책임자에게 E-mail등으로 연락하시면 즉시 개인정보의 삭제 등 필요한 조치를 하겠습니다.
본 사이트는 개인정보의 수집에 대한 회원탈퇴(동의철회)를 개인정보 수집시와 동등한 방법 및 절차로 행사할 수 있도록 필요한 조치를 하겠습니다.

9. 개인정보의 보유 및 이용기간

원칙적으로, 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다.
1) 보존 항목 : 회원가입정보(로그인ID, 이름, 별명)
2) 보존 근거 : 회원 탈퇴 시 다른 회원이 기존 회원아이디로 재가입하여 활동하지 못하도록 하기 위함
3) 보존 기간 : 영구
그리고 상법 등 관계법령의 규정에 의하여 보존할 필요가 있는 경우 회사는 아래와 같이 관계법령에서 정한 일정한 기간 동안 거래 및 회원정보를 보관합니다.
⚪보존 항목 : 계약 또는 청약철회 기록, 대금 결제 및 재화공급 기록, 불만 또는 분쟁처리 기록
⚪보존 근거 : 전자상거래등에서의 소비자보호에 관한 법률 제6조 거래기록의 보존
⚪보존 기간 : 계약 또는 청약철회 기록(5년), 대금 결제 및 재화공급 기록(5년), 불만 또는 분쟁처리 기록(3년), 위 보유기간에도 불구하고 계속 보유하여야 할 필요가 있을 경우에는 귀하의 동의를 받겠습니다.
⚪회원이 1년간 서비스 이용기록이 없는 경우[정보통신망 이용촉진 및 정보보호 등에 관한 법률] 제 29조 '개인정보 유효 기간제'에 따라 회원에게 사전 통지하고 별도로 분리하여 저장합니다. 
4) 개인정보의 국외 보관에 대한 내용
 회사는 이용자로부터 취득 또는 생성한 개인정보를 미리내가 보유하고 있는 데이터베이스 (물리적보관소: 한국)에 저장합니다. 미리내는 해당 서버의 물리적인 관리만을 행하고, 원칙적으로 회원님의 개인정보에 접근하지 않습니다. 


⚪이전항목: 서비스 이용기록 또는 수집된 개인정보
⚪이전국가: 한국
⚪이전일시 및 방법: 전산 서버 수탁계약 이후 서비스 이용 시점에 네트워크를 통한 전송
⚪개인정보 보유 및 이용기간: 회원탈퇴시 혹은 위탁계약 종료시까지 

10. 개인정보의 파기절차 및 방법

본 사이트는 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 파기절차 및 방법은 다음과 같습니다.
파기절차 : 귀하가 회원가입 등을 위해 입력하신 정보는 목적이 달성된 후 별도의 DB로 옮겨져(종이의 경우 별도의 서류함) 내부 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라(보유 및 이용기간 참조) 일정 기간 저장된 후 파기되어집니다. 별도 DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 보유되어지는 이외의 다른 목적으로 이용되지 않습니다.
파기방법 : 전자적 파일형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.

11. 아동의 개인정보 보호

본 사이트는 만14세 미만 아동의 개인정보를 수집하는 경우 법정대리인의 동의를 받습니다.
만14세 미만 아동의 법정대리인은 아동의 개인정보의 열람, 정정, 동의철회를 요청할 수 있으며, 이러한 요청이 있을 경우 본 사이트는 지체 없이 필요한 조치를 취합니다.

12. 개인정보 보호를 위한 기술적 대책

본 사이트는 귀하의 개인정보를 취급함에 있어 개인정보가 분실, 도난, 누출, 변조 또는 훼손되지 않도록 안전성 확보를 위하여 다음과 같은 기술적 대책을 강구하고 있습니다.
귀하의 개인정보는 비밀번호에 의해 보호되며, 파일 및 전송 데이터를 암호화하거나 파일 잠금기능(Lock)을 사용하여 중요한 데이터는 별도의 보안기능을 통해 보호되고 있습니다.
본 사이트는 백신프로그램을 이용하여 컴퓨터바이러스에 의한 피해를 방지하기 위한 조치를 취하고 있습니다. 백신프로그램은 주기적으로 업데이트되며 갑작스런 바이러스가 출현할 경우 백신이 나오는 즉시 이를 제공함으로써 개인정보가 침해되는 것을 방지하고 있습니다.
해킹 등에 의해 귀하의 개인정보가 유출되는 것을 방지하기 위해, 외부로부터의 침입을 차단하는 장치를 이용하고 있습니다.

13. 개인정보의 위탁처리
본 사이트는 서비스 향상을 위해서 귀하의 개인정보를 외부에 위탁하여 처리할 수 있습니다.
개인정보의 처리를 위탁하는 경우에는 미리 그 사실을 귀하에게 고지하겠습니다.
개인정보의 처리를 위탁하는 경우에는 위탁계약 등을 통하여 서비스제공자의 개인정보보호 관련 지시 엄수, 개인정보에 관한 비밀유지, 제3자 제공의 금지 및 사고시의 책임부담 등을 명확히 규정하고 당해 계약내용을 서면 또는 전자적으로 보관하겠습니다.

14. 의견수렴 및 불만처리
본 사이트는 개인정보보호와 관련하여 귀하가 의견과 불만을 제기할 수 있는 창구를 개설하고 있습니다. 개인정보와 관련한 불만이 있으신 분은 본 사이트의 개인정보 최고 관리책임자에게 의견을 주시면 접수 즉시 조치하여 처리결과를 통보해 드립니다.
1) 개인정보 최고 관리책임자는 회사의 대표가 직접 맡아서 개인정보에 대한 강조를 하고 있습니다. 개인정보를 보호하고 유출을 방지하는 책임자로서 이용자가 안심하고 회사가 제공하는 서비스를 이용할 수 있도록 도와드리며, 개인정보를 보호하는데 있어 이용자에게 고지한 사항들에 반하여 사고가 발생할 시에는 이에 관한 책임을 집니다.
2) 기술적인 보완조치를 취하였음에도 불구하고 악의적인 해킹 등 기본적인 네트워크상의 위험성에 의해 발생하는 예기치 못한 사고로 인한 정보의 훼손 및 멸실, 이용자가 작성한 게시물에 의한 각종 분쟁 등에 관해서는, 본 사이트 회사는 책임이 없습니다.
3) 회사는 정보통신망 이용촉진 및 정보보호 등에 관한 법률에서 규정한 관리책임자를 다음과 같이 지정합니다.
개인정보 최고 관리책임자 성명 : 
전화번호 :
이메일 : 

또는 개인정보침해에 대한 신고나 상담이 필요하신 경우에는 아래 기관에 문의하시기 바랍니다.
개인분쟁조정위원회 (www.1336.or.kr / 1336)
정보보호마크인증위원회 (www.eprivacy.or.kr / 02-580-0533~4)
대검찰청 인터넷범죄수사센터 (icic.sppo.go.kr / 02-3480-3600)
경찰청 사이버테러대응센터 (www.ctrc.go.kr / 02-392-0330)

15. 부 칙(시행일) 

현 개인정보처리방침은 2017년 9월 22일에 제정되었으며, 정부 및 회사의 정책 또는 보안기술의 변경에 따라 내용의 추가, 삭제 및 수정이 있을 경우에는 개정 최소 7일 전부터 ‘공지사항’란을 통해 고지하며, 본 정책은 시행 일자에 시행됩니다.
1) 공고일자 : 2018년 05월 01일
2) 시행일자 : 2018년 05월 01일
							</p>
						</div>
					</div>	
					<div id="check-line3">
						<p class="agreetext">광고성 정보 수신 동의</p>
						<input type="checkbox">
					</div>
					</form>
					<div id="check-content3">
						<div id="check-contentbox3">
							<p>	
[광고성 정보 수신 동의]

제1조 (목적)
본 약관은 티꿀모아(이하 "회사")가 제공하는 상품 및 서비스에 관한 광고성 정보를 전송하기 위한 수신 동의에 관한 사항을 규정함을 목적으로 합니다.

제2조 (광고성 정보의 정의)
"광고성 정보"란 상품/서비스에 관한 정보, 할인/이벤트 정보, 프로모션 안내 등 상업성 정보를 말합니다.

제3조 (수신 동의의 범위)
1. 회원은 이메일, SMS, 앱 푸시 알림을 통한 광고성 정보의 수신을 선택적으로 동의할 수 있습니다.
2. 광고성 정보는 주 1~2회 정도 발송되며, 이벤트 기간에는 발송 빈도가 변경될 수 있습니다.

제4조 (수신 동의의 철회)
1. 회원은 언제든지 수신 동의를 철회할 수 있습니다.
2. 수신 철회 방법:
   - 마이페이지 → 설정 → 알림설정에서 직접 설정 변경
   - 고객센터를 통한 수신거부 신청
   - 수신거부 문자 회신
   
제5조 (개인정보 보호)
회사는 광고성 정보 전송 목적으로 수집된 개인정보를 관련 법령에 따라 안전하게 보관하며, 수신 동의 철회 시 즉시 파기합니다.

제6조 (비용)
광고성 정보 수신에 대한 별도의 비용이 부과되지 않으나, 모바일 데이터 이용 시 통신사별 요금이 발생할 수 있습니다.

본 약관에 동의하시는 경우, 위 내용에 대해 인지하고 수신에 동의하는 것으로 간주됩니다.	
							</p>
						</div>
					</div>
				</div>
				<div id="agree-button">
				<div id="canclediv">
					<input type="reset" id="cancle" style="cursor: pointer; height:50px; border:none;" value="메인으로">
				</div>
				<div id="joindiv">
					<input type="button" id="join" value="회원가입">
				</div>
			</div>
			</section>
		</div>
	</div>
</main>
<script>
//서블릿에서 유효성 검사 후 알람 띄우기
	<c:if test="${errorMessage != null}">
		alert('${errorMessage}');
	</c:if>
	//메인으로 버튼 클릭시 메인페이지로 이동
	$("#cancle").click(function() {
		location.assign("${path}/home");
	});
	//로고 버튼 클릭시 메인페이지로 이동
	$(".logo-container").click(function() {
		location.assign("${path}");
	});
	//회원가입 버튼 클릭시 회원정보입력페이지로 이동
	$("#join").click(function() {
		//location.assign("${path}/member/enrollmain");
		$("#logincheck-frm").submit();
	});
</script>
<!-- 푸터 include -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<!-- wrap 태그 종료 -->
</div>

<!-- 8. 공통 JavaScript -->
<!-- 9. API/Ajax 관련 JavaScript -->
<!-- 10. 컴포넌트 JavaScript -->
<!-- 11. 페이지별 JavaScript -->
</body>
</html>