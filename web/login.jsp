<%-- 
    Document   : Login
    Created on : 05/11/2019, 00:19:54
    Author     : irvso
--%>

<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="aluno.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
         <%
            Login bd = new Login();
            bd.setLogEmail(request.getParameter("logemail"));
            bd.setLogSenha(request.getParameter("logsenha"));
            boolean a = false;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/boletim", "root", "");
                String sqlConsulta = "SELECT * FROM login WHERE email LIKE '%" + bd.getLogEmail() + "%' AND senha LIKE '%" + bd.getLogSenha()+ "%'";
                PreparedStatement stmt2 = conexao.prepareStatement(sqlConsulta);
                ResultSet rs = stmt2.executeQuery();
                while (rs.next()) {
                    a = true;
                    String email = rs.getString("email");
                    String senha = rs.getString("senha");
                    if (bd.getLogEmail().equals(email) && bd.getLogSenha().equals(senha)) {
                        
                       
                        response.sendRedirect("menualuno.html");
                    }
                }
                if (a == false) {
                    JOptionPane.showMessageDialog(null, "Login ou senha incorreta");
                    response.sendRedirect("index.html");
                }
            } catch (Exception e) {
                JOptionPane.showMessageDialog(null, "Erro" + e);
            }
        %>
        
        
    </body>
</html>
