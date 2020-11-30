<%-- 
    Document   : index
    Created on : 9 de nov de 2020, 15:11:23
    Author     : rlarg
--%>

<%@page import="model.Usuario"%>
<%@page import="web.DbListener"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
    String exceptionMessage = null;
    if(request.getParameter("FormAlterarSenha")!=null){
        try{
            String senhaAtual = request.getParameter("senhaAtual");
            String senhaNova = request.getParameter("senhaNova");
            String senhaNovaConfirmacao = request.getParameter("senhaNovaConfirmacao");
            String login = (String)session.getAttribute("session.login");
            Usuario u = Usuario.getUser(login, senhaAtual);
            if(u == null){
                exceptionMessage = "Senha inv�lida";
            }else{
                if(!senhaNova.equals(senhaNovaConfirmacao)){
                    exceptionMessage = "As senhas novas est�o diferentes";
                }else{
                    Usuario.changePassword(login, senhaNova);
                    response.sendRedirect(request.getRequestURI());
                }
            }
        }catch(Exception ex){
            exceptionMessage = ex.getLocalizedMessage();
        }
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Meu perfil - FINANCY$</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <h2>Meu Perfil</h2>
        <%if(session.getAttribute("session.login")==null){%>
            <div>� preciso estar logado para acessar esta p�gina</div>
        <%}else{%>
            <h3>Login</h3>
            <div><%= session.getAttribute("session.login") %></div>
            <h3>Nonme</h3>
            <div><%= session.getAttribute("session.nome") %></div>
            <h3>Papel</h3>
            <div><%= session.getAttribute("session.papel") %></div>
            <hr/>
            <%if(exceptionMessage!=null){%>
            <div style="color: red"><%= exceptionMessage %></div>
            <%}%>
            <fieldset>
                <legend>Alterar senha</legend>
                <form method="post">
                    <div>Senha atual:</div>
                    <div><input type="password" name="senhaAtual"/></div>
                    <div>Senha nova:</div>
                    <div><input type="password" name="senhaNova"/></div>
                    <div>Senha nova (confirma��o):</div>
                    <div><input type="password" name="senhaNovaConfirmacao"/></div>
                    <hr/>
                    <input type="submit" name="FormAlterarSenha" value="Redefinir"/>
                </form>
            </fieldset>
        <%}%>
    </body>
</html>
