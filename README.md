# SEMI_Project
===========================================================================
- main branch에 합쳐진 경우에만 작성해주세요

2024-11-02 마이페이지 commit










===========================================================================

SEMI_Project

각 파일에 DAO.java filePath 변경해주세요
java/resources 로 경로 변경해주시고
XXXDao(해당 클래스파일명).class.getResource("/resource/mappers/사용하는 mapper.xml").getPath();

************ 작성 기준 ************

매핑주소 : 
1) 페이지 이동용 매핑주소 : 이동하는 페이지명.파일명 두 글자
ex) .do / .me / .us 등등
2) 기능 구현을 위한 매핑주소 : CRUD(SQL) + 사용테이블명.파일명 두 글자
ex) .do / .me / .us 등등 ex) insertUser.us -> 회원가입 매핑주소

Controller
1) 페이지 이동용 controller : 이동하는 페이지명 + Controller
2) 기능 구현을 위한 controller : 테이블명 + CRUD(SQL) + Controller
   
메소드명
- CRUD + 테이블명 또는 기능명()
ex) insertUserInfo() -> 회원정보 삽입 메소드
ex) selectUserInfo() -> 로그인한 정보를 가지고 UserInfo테이블에 있는 회원인지 확인하는 메소드

    
************ 작성시 주의사항 **************
		
1. 이미 작성되어있는 파일의 경우에는 변경 전에 먼저 슬랙에 말씀해주세요.
2. dao의 경우 상단에 Connection(con), PreparedStatement(pstmt), ResultSet(rset), Properties(pro) 객체들은 생성되어있습니다.
	 따로 메소드 안에서 생성하실 필요없습니다.
3. Controller에 경우 위 작성 기준에 맞게 작성해주세요.
4. 상점이미지와 통합게시판에서 사용하는 이미지는 /resources/해당파일명/해당이미지명.확장자
5. 파일명 변경하는 클래스 재정의 해뒀습니다 (new MyFileRenamePolicy())
6. jsp파일 생성시 /views/상위파일명/파일명.jsp로 작성해주세요.

============================================================

   한 페이지로 구현 예정
- 기본적으로 비회원은 게시판 이용이 불가

1. 메인화면
- 로그인 / 회원가입 - 회원테이블 👉<현재 로그인한 유저의 정보는 loginUser에 저장합니다>
- 통합게시판 이동
- 마이페이지 이동

2. 통합게시판 - 통합게시판테이블, 카테고리 테이블, 추천수 테이블
- 게시판 페이지에 보여줄 목록 (게시물 번호, 카테고리 타입, 게시물 제목, 게시물 작성자, 조회수, 작성일, 추천수)
- 공지사항 작성 - 작성시 태그에 관리자만 '공지' 태그가 보임
- 상단 태그로 게시판 종류 표시 - 관리자만 삭제 기능부여
 (통합, 인기, 자유, 챌린지, 전문가, 식단, 공지)
- 통합, 인기, 자유, 챌린지, 전문가, 식단, 공지 별게시물 검색기능 (키워드 검색)

3. 상점 페이지
- 상품 구매 (구매시 환불 불가)
- 상품 등록 및 삭제 기능 (관리자만 확인 가능)

4. 마이페이지 - 회원테이블, 구매상품테이블, 회원등급테이블, 로그인횟수테이블, 운동기록 테이블
- 운동 기록 (완)
- 나의 운동 기록 상세보기 (완)
- 포인트 및 구매한 상품 내역 조회, 로그인 횟수 출력 (완)
- 회원 탈퇴 및 회원 정보 수정, 비밀번호 변경 (버튼만 구현한 상태 - 기능 x)
- 문의글 작성 & 내가 작성한 문의 내역 조회 및 상세보기(완)
- 각 게시물(문의, 운동기록, 아이템) 삭제 버튼 구현 (완)
- 아이템 사용 눌렀을때 사용메시지 출력 및 갯수 감소 (완)

5. 관리자 페이지 - 통합게시판, 상품테이블, 광고대기테이블, 
- 아이템 구매 현황 확인 기능 (광고 대기열 테이블 이용)
- 커뮤니티 내 광고(아이템) 대기열 확인 기능 - 알림기능
- 회원들이 작성한 문의 내역 조회 및 상세보기 , 답변달기
- 모든 문의 게시글 조회 기능

각 항목에 완료도 표시
EX) (완) OR 70%




















