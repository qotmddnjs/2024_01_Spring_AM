<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원정보 수정</title>
    
    <link rel="stylesheet" type="text/css" th:href="@{/css/bootstrap.css}" />
   
    <script type="text/javascript" th:src="@{/js/bootstrap.min.js}"></script>
</head>
<body>
    
    
    <div style="padding: 20px;">
        
        <h3>회원정보 수정</h3>
        <hr />
        <form th:action="@{/member/update}" method="post">

            아이디: <input type="text" name="id" th:value="${member.id}" readonly /> <br />
            이름: <input type="text" name="name" th:value="${member.name}" /> <br />
            나이: <input type="text" name="age" th:value="${member.age}" /> <br />
            <input type="submit" value="수정" />

        </form>
        
    </div>
    

</body>
</html>