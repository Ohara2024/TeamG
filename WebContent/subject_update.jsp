<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>科目変更画面</title>
    <style>
        .error {
            color: red;
            font-size: 0.9em;
        }
    </style>
</head>
<body>

<h2>科目情報変更</h2>


<form id="subjectForm">
    <label for="cdtxt">科目コード（半角英数字のみ）</label><br>
    <input type="text" id="cdtxt" name="cdtxt" value="${cd}"><br>
    <span id="codeError" class="error"></span><br><br>

    <label for="name">科目名</label><br>
    <input type="text" id="name" name="name" value="${name}"><br>
    <span id="nameError" class="error"></span><br><br>

    <input type="submit" value="更新">
    <a href="SubjectList">戻る</a>
</form>

<script>
document.getElementById("subjectForm").addEventListener("submit", function(event) {
    event.preventDefault();

    const codeField = document.getElementById("cdtxt");
    const nameField = document.getElementById("name");
    const codeError = document.getElementById("codeError");
    const nameError = document.getElementById("nameError");

    let valid = true;
    codeError.textContent = "";
    nameError.textContent = "";

    const codeValue = codeField.value.trim();
    if (!/^[A-Za-z0-9]+$/.test(codeValue)) {
        codeError.textContent = "半角英数字で入力してください";
        valid = false;
    }

    const nameValue = nameField.value.trim();
    if (nameValue === "") {
        nameError.textContent = "このフィールドに入力してください";
        valid = false;
    }

    if (valid) {

    window.location.href = "subject_update_done.jsp";
    }
});
</script>

</body>
</html>
