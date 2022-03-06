<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <c:url value="/css/main.css" var="jstlCss" />
    <c:url value="/bootstrap-5.1.1-dist/css/bootstrap.min.css" var="jstlBootstrap" />
    <c:url value="/bootstrap-5.1.1-dist/js/bootstrap.bundle.min.js" var="jstlBootstrapJS" />
    <c:url value="/images" var="jstlImages" />
    <link href="${jstlCss}" rel="stylesheet" >
    <link href="${jstlBootstrap}" rel="stylesheet" >
    <script src="${jstlBootstrapJS}">

    </script>
    <title>Usage of ${rootWord}</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<div class="accordion" id="myAccordian">
    <c:set var="index" value="1" scope="page" />
    <c:forEach items="${dictionary}" var="dc">

        <div class="accordion-item">
            <h2 class="accordion-header" id="heading${index}">
                <button id="button${index}" onclick="toggle(${index})" class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${index}" aria-expanded="false" aria-controls="collapse${index}">
                        ${dc.getParentType()} - ${dc.getChildType()} - ${dc.getListQuranView().size()}
                </button>
            </h2>
            <div id="collapse${index}" class="accordion-collapse collapse" aria-labelledby="heading${index}" data-bs-parent="#myAccordian">
                <div class="accordion-body">
                        <%--                <table class="table">--%>
                        <%--                    <tbody>--%>
                    <c:forEach items="${dc.getListQuranView()}" var="detail">
                        <%--                        <tr>--%>
                        <div class="row">
                            <div class="col-3"><span class="l">(${detail.getChapter()}:${detail.getVerse()}:${detail.getToken()})</span> <i class="ab">${detail.getBuckwalter()}</i></div>
                            <div class="col-3"><a name="(13:17:36)" href="wordmorphology.jsp?location=(13:17:36)">${detail.getEnglish()}</a></div>
                            <c:set var="verseArray" value="${fn:split(detail.getVerseText(),' ')}"/>
                            <div class="col-6" style="text-align:right;font-size:large;font-weight: bold">${fn:replace(detail.getVerseText(), verseArray[detail.getToken()-1],"<span style='color:red;font-weight: bold;'>".concat(verseArray[detail.getToken()-1]).concat("</span>"))}</div>
                        </div>
                        <%--                        </tr>--%>
                    </c:forEach>

                        <%--                    </tbody>--%>
                        <%--                </table>--%>
                </div>
            </div>
        </div>
        <c:set var="index" value="${index + 1}" scope="page"/>

    </c:forEach>
</div>

<%--<div class="accordion" id="accordionPanelsStayOpenExample">--%>
<%--    <div class="accordion-item">--%>
<%--        <h2 class="accordion-header" id="panelsStayOpen-headingOne">--%>
<%--            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">--%>
<%--                Accordion Item #1--%>
<%--            </button>--%>
<%--        </h2>--%>
<%--        <div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne">--%>
<%--            <div class="accordion-body">--%>
<%--                <div class='row'><div class='col-12'>Testingfjdkfjdfkdfjdl</div></div>--%>
<%--                <div class='row'><div class='col-12'>Testingfjdkfjdfkdfjdl</div></div>--%>
<%--                <div class='row'><div class='col-12'>Testingfjdkfjdfkdfjdl</div></div>--%>
<%--                <div class='row'><div class='col-12'>Testingfjdkfjdfkdfjdl</div></div>--%>
<%--                <div class='row'><div class='col-12'>Testingfjdkfjdfkdfjdl</div></div>--%>
<%--                <div class='row'><div class='col-12'>Testingfjdkfjdfkdfjdl</div></div>--%>
<%--                <div class='row'><div class='col-12'>Testingfjdkfjdfkdfjdl</div></div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    <div class="accordion-item">--%>
<%--        <h2 class="accordion-header" id="panelsStayOpen-headingTwo">--%>
<%--            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false" aria-controls="panelsStayOpen-collapseTwo">--%>
<%--                Accordion Item #2--%>
<%--            </button>--%>
<%--        </h2>--%>
<%--        <div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingTwo">--%>
<%--            <div class="accordion-body">--%>
<%--                <div class='row'><div class='col-12'>Testingfjdkfjdfkdfjdl</div></div>--%>
<%--                <div class='row'><div class='col-12'>Testingfjdkfjdfkdfjdl</div></div>--%>
<%--                <div class='row'><div class='col-12'>Testingfjdkfjdfkdfjdl</div></div>--%>
<%--                <div class='row'><div class='col-12'>Testingfjdkfjdfkdfjdl</div></div>--%>
<%--                <div class='row'><div class='col-12'>Testingfjdkfjdfkdfjdl</div></div>--%>
<%--                <div class='row'><div class='col-12'>Testingfjdkfjdfkdfjdl</div></div>--%>
<%--                <div class='row'><div class='col-12'>Testingfjdkfjdfkdfjdl</div></div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    <div class="accordion-item">--%>
<%--        <h2 class="accordion-header" id="panelsStayOpen-headingThree">--%>
<%--            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="false" aria-controls="panelsStayOpen-collapseThree">--%>
<%--                Accordion Item #3--%>
<%--            </button>--%>
<%--        </h2>--%>
<%--        <div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingThree">--%>
<%--            <div class="accordion-body">--%>
<%--                <div class='row'><div class='col-12'>Testingfjdkfjdfkdfjdl</div></div>--%>
<%--                <div class='row'><div class='col-12'>Testingfjdkfjdfkdfjdl</div></div>--%>
<%--                <div class='row'><div class='col-12'>Testingfjdkfjdfkdfjdl</div></div>--%>
<%--                <div class='row'><div class='col-12'>Testingfjdkfjdfkdfjdl</div></div>--%>
<%--                <div class='row'><div class='col-12'>Testingfjdkfjdfkdfjdl</div></div>--%>
<%--                <div class='row'><div class='col-12'>Testingfjdkfjdfkdfjdl</div></div>--%>
<%--                <div class='row'><div class='col-12'>Testingfjdkfjdfkdfjdl</div></div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<div class="accordion" id="accordionExample">--%>
<%--    <div class="accordion-item">--%>
<%--        <h2 class="accordion-header" id="headingOne">--%>
<%--            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">--%>
<%--                Accordion Item #1--%>
<%--            </button>--%>
<%--        </h2>--%>
<%--        <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">--%>
<%--            <div class="accordion-body">--%>
<%--                <table class="table">--%>
<%--                    <thead>--%>
<%--                    <tr>--%>
<%--                        <th scope="col">#</th>--%>
<%--                        <th scope="col">First</th>--%>
<%--                        <th scope="col">Last</th>--%>
<%--                        <th scope="col">Handle</th>--%>
<%--                    </tr>--%>
<%--                    </thead>--%>
<%--                    <tbody>--%>
<%--                    <tr>--%>
<%--                        <th scope="row">1</th>--%>
<%--                        <td>Mark</td>--%>
<%--                        <td>Otto</td>--%>
<%--                        <td>@mdo</td>--%>
<%--                    </tr>--%>
<%--                    <tr>--%>
<%--                        <th scope="row">2</th>--%>
<%--                        <td>Jacob</td>--%>
<%--                        <td>Thornton</td>--%>
<%--                        <td>@fat</td>--%>
<%--                    </tr>--%>
<%--                    <tr>--%>
<%--                        <th scope="row">3</th>--%>
<%--                        <td colspan="2">Larry the Bird</td>--%>
<%--                        <td>@twitter</td>--%>
<%--                    </tr>--%>
<%--                    </tbody>--%>
<%--                </table>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    <div class="accordion-item">--%>
<%--        <h2 class="accordion-header" id="headingTwo">--%>
<%--            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">--%>
<%--                Accordion Item #2--%>
<%--            </button>--%>
<%--        </h2>--%>
<%--        <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">--%>
<%--            <div class="accordion-body">--%>
<%--                <strong>This is the second item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    <div class="accordion-item">--%>
<%--        <h2 class="accordion-header" id="headingThree">--%>
<%--            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">--%>
<%--                Accordion Item #3--%>
<%--            </button>--%>
<%--        </h2>--%>
<%--        <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">--%>
<%--            <div class="accordion-body">--%>
<%--                <strong>This is the third item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>


</body>
</html>