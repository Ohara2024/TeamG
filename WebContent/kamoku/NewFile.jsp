<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>成績登録</title>
</head>
<body>
    <h2>成績登録フォーム</h2>

    <form action="TestRegistAction" method="post">
        <label>学年：</label>
        <select name="grade">
            <option value="1">1年</option>
            <option value="2">2年</option>
            <option value="3">3年</option>
        </select>
        <br><br>

        <label>クラス：</label>
        <select name="classCode">
            <option value="A">Aクラス</option>
            <option value="B">Bクラス</option>
            <option value="C">Cクラス</option>
        </select>
        <br><br>

        <label>科目：</label>
        <select name="subjectCode">
            <option value="MATH">数学</option>
            <option value="ENG">英語</option>
            <option value="SCI">理科</option>
        </select>
        <br><br>

        <label>担当者：</label>
        <input type="text" name="teacherName">
        <br><br>

        <label>点数：</label>
        <input type="number" name="score" min="0" max="100">
        <br><br>

        <input>