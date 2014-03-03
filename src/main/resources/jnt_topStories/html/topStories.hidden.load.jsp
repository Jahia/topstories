<%@ page import="org.apache.jackrabbit.util.ISO8601" %>
<%@ page import="java.util.Calendar" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>

<c:if test="${renderContext.editMode}"><h4><fmt:message key="label.topStoriesArea"/></h4>
    <p><fmt:message key="label.componentDescription"/></p>
</c:if>
<c:if test="${currentNode.properties['j:limit'].long gt 0}">
    <%
        pageContext.setAttribute("nowISO8601", ISO8601.format(Calendar.getInstance()));
    %>
    <query:definition var="listQuery"
                      statement="select * from [jmix:topStory] as story where isdescendantnode(story, ['${renderContext.site.path}'])
         and story.[j:level]='${currentNode.properties['j:level'].string}' and (story.[j:endDate] is null or story.[j:endDate] > '${nowISO8601}') order by story.[jcr:lastModified] desc"
         limit="${currentNode.properties['j:limit'].long}"/>

    <c:set target="${moduleMap}" property="editable" value="false" />
    <c:set target="${moduleMap}" property="listQuery" value="${listQuery}" />
</c:if>
