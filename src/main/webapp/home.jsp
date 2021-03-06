<%@page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
    <c:url value="/css/main.css" var="jstlCss" />
    <c:url value="/js/main.js" var="jstlJS" />
    <c:url value="/bootstrap-5.1.1-dist/css/bootstrap.min.css" var="jstlBootstrap" />
    <c:url value="/bootstrap-5.1.1-dist/js/bootstrap.bundle.min.js" var="jstlBootstrapJS" />
    <link href="${jstlBootstrap}" rel="stylesheet" >
    <style>
        .modal-dialog-width{
            /*overflow-y: initial !important;*/
            max-width: 1200px !important;
        }
        .modal-body{
            max-height: calc(100vh - 200px);
            overflow-y: auto;
        }
    </style>
    <script src="${jstlBootstrapJS}">
    </script>
    <script src="${jstlJS}">
    </script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        var tokens = ${tokens.size()};
        var chapter = ${chapter};
        var verse = ${verse};
        var totalCount = 0;

        $(document).ready(function(){
            $("#chapterList").change(function(){
                navigateVerse(true);
            });
            $("#verseList").change(function(){
                navigateVerse(false);
            });
            getMoreVerses(false);
        });

        var verseCounts = new Array(7, 286, 200, 176, 120, 165, 206, 75, 129, 109, 123,
            111, 43, 52, 99, 128, 111, 110, 98, 135, 112, 78, 118, 64, 77, 227, 93,
            88, 69, 60, 34, 30, 73, 54, 45, 83, 182, 88, 75, 85, 54, 53, 89, 59,
            37, 35, 38, 29, 18, 45, 60, 49, 62, 55, 78, 96, 29, 22, 24, 13, 14, 11,
            11, 18, 12, 12, 30, 52, 52, 44, 28, 28, 20, 56, 40, 31, 50, 40, 46, 42,
            29, 19, 36, 25, 22, 17, 19, 26, 30, 20, 15, 21, 11, 8, 8, 19, 5, 8, 8,
            11, 11, 8, 3, 9, 5, 4, 7, 3, 6, 3, 5, 4, 5, 6);


        window.onscroll = function(ev) {
            if ((window.innerHeight + window.pageYOffset) >= document.body.offsetHeight) {
                getMoreVerses(true);
            }
        };

        function toggle(id){
            if($("#button" + id).attr("aria-expanded") == "true"){
                console.log("true");
                $("#button" + id).attr("aria-expanded", "false");
                $("#collapse" + id).removeClass("show");
                console.log($("#button" + id).attr("aria-expanded"));
            } else {
                console.log("false");
                $("#button" + id).attr("aria-expanded", "true");
                $("#collapse" + id).addClass("show");
                console.log($("#button" + id).attr("aria-expanded"));
            }

        }

        function load_accordian(jsonData){
                totalCount = 0;
                var str = "";
                str = str + "<div class=\"accordion\" id=\"myAccordian\">";
                for (var i = 0; i < jsonData.length; i++) {
                str = str + "<div class=\"accordion-item\">";
                str = str + "<h2 class=\"accordion-header\" id=\"heading" + i + "\">";
                str = str + "<button id=\"button" + i + "\" class=\"accordion-button collapsed\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#collapse" + i + "\" aria-expanded=\"false\" aria-controls=\"collapse" + i + "\">";
                var item = jsonData[i];
                var detail = item.listQuranView;
                str = str + item.parentType + " - " + item.childType + " - " + detail.length;
                totalCount = totalCount + detail.length;
                str = str + "</button>";
                str = str + "</h2>";
                str = str + "<div id=\"collapse" + i + "\" class=\"accordion-collapse collapse\" aria-labelledby=\"heading" + i + "\" data-bs-parent=\"#myAccordian\">";
                str = str + "<div class=\"accordion-body\">";
                for(j=0;j<detail.length;j++){
                    var detailItem = detail[j];
                    str = str + "<div class=\"row\">";
                    str = str + "<div class=\"col-3\"><span class=\"l\">(" + detailItem.chapter + ":" +  detailItem.verse + ":" + detailItem.token + ")</span> <i class=\"ab\">" + detailItem.buckwalter + "</i></div>";
                    str = str + "<div class=\"col-3\"><a name=\"(13:17:36)\" href='\\?chapter=" + detailItem.chapter + "&verse=" + detailItem.verse +"'>" + detailItem.english + "</a></div>";
                    var verseText = detailItem.verseText;
                    verseArray = verseText.split(" ");
                    str = str + "<div class=\"col-6\" style=\"text-align:right;font-size:large;font-weight: bold\">" + verseText.replace(verseArray[detailItem.token-1],"<span style='color:red;font-weight: bold;'>" + verseArray[detailItem.token-1] + "</span>") + "</div>";
                    str = str + "</div>";
                }

                str = str + "</div>";
                str = str + "</div>";
                str = str + "</div>";
            }
            str = str + "</div>";
            return str;
        }

        function updateVerses() {
            var chapterList = document.getElementById("chapterList");
            var chapterNumber = parseInt(chapterList.value);

            var verseList = document.getElementById("verseList");
            var verseNumber = parseInt(verseList.value);

            verseList.options.length = 0;
            var verseCount = verseCounts[chapterNumber - 1];
            for ( var i = 1; i <= verseCount; i++) {
                verseList.options[verseList.options.length] = new Option("Verse ("
                    + chapterNumber + ":" + i + ")", i);
            }

            if (verseNumber <= verseCount) {
                verseList.value = verseNumber;
            }
        }

        function navigateVerse(chapterChange) {
            var chapterList = document.getElementById("chapterList");
            var verseList = document.getElementById("verseList");
            var verse;
            if(chapterChange){
                myVerse = 1;
            } else {
                myVerse = verseList.value;
            }
            document.location.href = '?chapter=' + chapterList.value + '&verse='
                + myVerse;
        }

        function find_usages(rootWord){


            $.ajax({
                type: "get",
                url: "/usages",
                data: "rootWord="+rootWord,
                success: function(data) {
                    $('.modal-body').html(load_accordian(data));
                    $('.modal-title').html("'" + rootWord + "' Came " + totalCount + " times");
                    // Display Modal
                    $('#exampleModal').modal('show');
                }
            });
        }

        function getMoreVerses(incrementVerse) {
            totalVersesInChapter = verseCounts[chapter-1];
            if(incrementVerse && (totalVersesInChapter == verse || verse > totalVersesInChapter)){
                return;
            }
            if(incrementVerse){
                verse = verse + 1;
            }

            $.ajax({
                type: "get",
                url: "/getTokens",
                data: "verse="+verse+"&chapter="+chapter,
                success: function(data) {
                    load_more(data);
                    tokens = tokens + data.length;
                    if(tokens < 15){
                        getMoreVerses(true);
                    }
                }
            });
        }

        function load_more(jsonData) {
            var str = "";
            var href = "http://localhost:8080/images/";
            var css;
            var englishGrammer;
            var arabicGrammer;
            var cssStringDetail;
            for (var i = 0; i < jsonData.length; i++) {
                token = jsonData[i];
                str = "";
                if(verse%2 == 0)
                    str = "<div class='row border-bottom border-dark py-2 bg-info bg-opacity-10'>";
                else
                    str = "<div class='row border-bottom border-dark py-2'>";
                str = str + "<div class='col-3'>";
                str = str + "<span class='phonetic'>" + token.english + "</span><br><span class='location'>Verse:" + token.verse + " Token:" + token.token + "</span><br>";
                if(token.rootWord != ""){
                    //str = str + token.rootWord + " ";
                    //str = str + "<a name='usage' data-toggle='Find Usages in Quran'  href='javascript:find_usages(\"" + token.rootWord + "\")'>" + token.rootWord + "</a>";
                    str = str + "<button type='button' onclick='javascript:find_usages(\"" + token.rootWord + "\")' class='btn btn-info'>" + token.rootWord + "</button>";
                    str = str + "";
                }
                str = str + "</div>";
                str = str + "<div class='col-4 center-block text-center'>";
                str = str + "<img src='" +  href + "/"  + token.chapter + "/" + token.img + ".png'>";

                str = str + "</div>";
                str = str + "<div class='col-5'>";
                css = token.cssString.split("~");
                englishGrammer = token.englishGrammer.split("~");
                arabicGrammer = token.arabicGrammer;
                cssStringDetail = token.cssStringDetail.split("~");
                for (var j = 0; j < cssStringDetail.length; j++) {
                    str = str + "<b class='" + css[j] +"'>" + englishGrammer[j] + "</b>-" + cssStringDetail[j];
                    str = str + "<br>";
                }
                str = str + "<div class='arabicGrammar'>" + arabicGrammer.replace('~','<br>') + "</div>";
                str = str + "</div>";
                str = str + "</div>";
                str = str + "<span class='border-bottom'></span>";
                html = $.parseHTML(str);
                $("#mainDiv").append(html[0]);
            }
        }
    </script>
    <c:url value="/css/main.css" var="jstlCss" />
    <c:url value="/images" var="jstlImages" />
    <link href="${jstlCss}" rel="stylesheet" >
    <title>>Hello ${name}!</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<div class="container">
<div class="row">
<%--<div class="col-1">--%>
<%--</div>--%>
<div class ="col-12">
<div class="container fixed-top bg-white">
    <div class="row border-bottom border-dark py-1">
        <div class="col-12">
            <select name="chapterList" id="chapterList"><option value="1">Chapter (1) s??rat l-f??ti???ah (The Opening)</option><option value="2">Chapter (2) s??rat l-baqarah (The Cow)</option><option value="3">Chapter (3) s??rat ??l ??im'r??n (The Family of Imr??n)</option><option value="4">Chapter (4) s??rat l-nis??a (The Women)</option><option value="5">Chapter (5) s??rat l-m??idah (The Table spread with Food)</option><option value="6">Chapter (6) s??rat l-an????m (The Cattle)</option><option value="7">Chapter (7) s??rat l-a??r??f (The Heights)</option><option value="8">Chapter (8) s??rat l-anf??l (The Spoils of War)</option><option selected="selected" value="9">Chapter (9) s??rat l-tawbah (The Repentance)</option><option value="10">Chapter (10) s??rat y??nus (Jonah)</option><option value="11">Chapter (11) s??rat h??d (Hud)</option><option value="12">Chapter (12) s??rat y??suf (Joseph)</option><option value="13">Chapter (13) s??rat l-ra??d (The Thunder)</option><option value="14">Chapter (14) s??rat ib'r??h??m (Abraham)</option><option value="15">Chapter (15) s??rat l-???ij'r (The Rocky Tract)</option><option value="16">Chapter (16) s??rat l-na???l (The Bees)</option><option value="17">Chapter (17) s??rat l-isr?? (The Night Journey)</option><option value="18">Chapter (18) s??rat l-kahf (The Cave)</option><option value="19">Chapter (19) s??rat maryam (Mary)</option><option value="20">Chapter (20) s??rat ????? h??</option><option value="21">Chapter (21) s??rat l-anbiy??a (The Prophets)</option><option value="22">Chapter (22) s??rat l-???aj (The Pilgrimage)</option><option value="23">Chapter (23) s??rat l-mu'min??n (The Believers)</option><option value="24">Chapter (24) s??rat l-n??r (The Light)</option><option value="25">Chapter (25) s??rat l-fur'q??n (The Criterion)</option><option value="26">Chapter (26) s??rat l-shu??ar?? (The Poets)</option><option value="27">Chapter (27) s??rat l-naml (The Ants)</option><option value="28">Chapter (28) s??rat l-qa???a??? (The Stories)</option><option value="29">Chapter (29) s??rat l-??ankab??t (The Spider)</option><option value="30">Chapter (30) s??rat l-r??m (The Romans)</option><option value="31">Chapter (31) s??rat luq'm??n</option><option value="32">Chapter (32) s??rat l-sajdah (The Prostration)</option><option value="33">Chapter (33) s??rat l-a???z??b (The Combined Forces)</option><option value="34">Chapter (34) s??rat saba (Sheba)</option><option value="35">Chapter (35) s??rat f?????ir (The Originator)</option><option value="36">Chapter (36) s??rat y?? s??n</option><option value="37">Chapter (37) s??rat l-?????f??t (Those Ranges in Ranks)</option><option value="38">Chapter (38) s??rat ?????d</option><option value="39">Chapter (39) s??rat l-zumar (The Groups)</option><option value="40">Chapter (40) s??rat gh??fir (The Forgiver God)</option><option value="41">Chapter (41) s??rat fu??????ilat (Explained in Detail)</option><option value="42">Chapter (42) s??rat l-sh??r?? (Consultation)</option><option value="43">Chapter (43) s??rat l-zukh'ruf (The Gold Adornment)</option><option value="44">Chapter (44) s??rat l-dukh??n (The Smoke)</option><option value="45">Chapter (45) s??rat l-j??thiyah (Crouching)</option><option value="46">Chapter (46) s??rat l-a???q??f (The Curved Sand-hills)</option><option value="47">Chapter (47) s??rat mu???ammad</option><option value="48">Chapter (48) s??rat l-fat??? (The Victory)</option><option value="49">Chapter (49) s??rat l-???ujur??t (The Dwellings)</option><option value="50">Chapter (50) s??rat q??f</option><option value="51">Chapter (51) s??rat l-dh??riy??t (The Wind that Scatter)</option><option value="52">Chapter (52) s??rat l-?????r (The Mount)</option><option value="53">Chapter (53) s??rat l-najm (The Star)</option><option value="54">Chapter (54) s??rat l-qamar (The Moon)</option><option value="55">Chapter (55) s??rat l-ra???m??n (The Most Gracious)</option><option value="56">Chapter (56) s??rat l-w??qi??ah (The Event)</option><option value="57">Chapter (57) s??rat l-???ad??d (The Iron)</option><option value="58">Chapter (58) s??rat l-muj??dilah (She That Disputeth)</option><option value="59">Chapter (59) s??rat l-???ashr (The Gathering)</option><option value="60">Chapter (60) s??rat l-mum'ta???anah (The Woman to be examined)</option><option value="61">Chapter (61) s??rat l-???af (The Row)</option><option value="62">Chapter (62) s??rat l-jumu??ah (Friday)</option><option value="63">Chapter (63) s??rat l-mun??fiq??n (The Hypocrites)</option><option value="64">Chapter (64) s??rat l-tagh??bun (Mutual Loss &amp; Gain)</option><option value="65">Chapter (65) s??rat l-???al??q (The Divorce)</option><option value="66">Chapter (66) s??rat l-ta???r??m (The Prohibition)</option><option value="67">Chapter (67) s??rat l-mulk (Dominion)</option><option value="68">Chapter (68) s??rat l-qalam (The Pen)</option><option value="69">Chapter (69) s??rat l-?????qah (The Inevitable)</option><option value="70">Chapter (70) s??rat l-ma????rij (The Ways of Ascent)</option><option value="71">Chapter (71) s??rat n?????</option><option value="72">Chapter (72) s??rat l-jin (The Jinn)</option><option value="73">Chapter (73) s??rat l-muzamil (The One wrapped in Garments)</option><option value="74">Chapter (74) s??rat l-mudathir (The One Enveloped)</option><option value="75">Chapter (75) s??rat l-qiy??mah (The Resurrection)</option><option value="76">Chapter (76) s??rat l-ins??n (Man)</option><option value="77">Chapter (77) s??rat l-mur'sal??t (Those sent forth)</option><option value="78">Chapter (78) s??rat l-naba (The Great News)</option><option value="79">Chapter (79) s??rat l-n??zi????t (Those who Pull Out)</option><option value="80">Chapter (80) s??rat ??abasa (He frowned)</option><option value="81">Chapter (81) s??rat l-takw??r (The Overthrowing)</option><option value="82">Chapter (82) s??rat l-infi?????r (The Cleaving)</option><option value="83">Chapter (83) s??rat l-mu???afif??n (Those Who Deal in Fraud)</option><option value="84">Chapter (84) s??rat l-inshiq??q (The Splitting Asunder)</option><option value="85">Chapter (85) s??rat l-bur??j (The Big Stars)</option><option value="86">Chapter (86) s??rat l-?????riq (The Night-Comer)</option><option value="87">Chapter (87) s??rat l-a??l?? (The Most High)</option><option value="88">Chapter (88) s??rat l-gh??shiyah (The Overwhelming)</option><option value="89">Chapter (89) s??rat l-fajr (The Dawn)</option><option value="90">Chapter (90) s??rat l-balad (The City)</option><option value="91">Chapter (91) s??rat l-shams (The Sun)</option><option value="92">Chapter (92) s??rat l-layl (The Night)</option><option value="93">Chapter (93) s??rat l-???u????? (The Forenoon)</option><option value="94">Chapter (94) s??rat l-shar??? (The Opening Forth)</option><option value="95">Chapter (95) s??rat l-t??n (The Fig)</option><option value="96">Chapter (96) s??rat l-??alaq (The Clot)</option><option value="97">Chapter (97) s??rat l-qadr (The Night of Decree)</option><option value="98">Chapter (98) s??rat l-bayinah (The Clear Evidence)</option><option value="99">Chapter (99) s??rat l-zalzalah (The Earthquake)</option><option value="100">Chapter (100) s??rat l-????diy??t (Those That Run)</option><option value="101">Chapter (101) s??rat l-q??ri??ah (The Striking Hour)</option><option value="102">Chapter (102) s??rat l-tak??thur (The piling Up)</option><option value="103">Chapter (103) s??rat l-??a???r (Time)</option><option value="104">Chapter (104) s??rat l-humazah (The Slanderer)</option><option value="105">Chapter (105) s??rat l-f??l (The Elephant)</option><option value="106">Chapter (106) s??rat quraysh</option><option value="107">Chapter (107) s??rat l-m??????n (Small Kindnesses)</option><option value="108">Chapter (108) s??rat l-kawthar (A River in Paradise)</option><option value="109">Chapter (109) s??rat l-k??fir??n (The Disbelievers)</option><option value="110">Chapter (110) s??rat l-na???r (The Help)</option><option value="111">Chapter (111) s??rat l-masad (The Palm Fibre)</option><option value="112">Chapter (112) s??rat l-ikhl????? (Sincerity)</option><option value="113">Chapter (113) s??rat l-falaq (The Daybreak)</option><option value="114">Chapter (114) s??rat l-n??s (Mankind)</option></select>
            <select name="verseList" id="verseList"><option value="1">Verse (9:1)</option><option value="2">Verse (9:2)</option><option selected="selected" value="3">Verse (9:3)</option><option value="4">Verse (9:4)</option><option value="5">Verse (9:5)</option><option value="6">Verse (9:6)</option><option value="7">Verse (9:7)</option><option value="8">Verse (9:8)</option><option value="9">Verse (9:9)</option><option value="10">Verse (9:10)</option><option value="11">Verse (9:11)</option><option value="12">Verse (9:12)</option><option value="13">Verse (9:13)</option><option value="14">Verse (9:14)</option><option value="15">Verse (9:15)</option><option value="16">Verse (9:16)</option><option value="17">Verse (9:17)</option><option value="18">Verse (9:18)</option><option value="19">Verse (9:19)</option><option value="20">Verse (9:20)</option><option value="21">Verse (9:21)</option><option value="22">Verse (9:22)</option><option value="23">Verse (9:23)</option><option value="24">Verse (9:24)</option><option value="25">Verse (9:25)</option><option value="26">Verse (9:26)</option><option value="27">Verse (9:27)</option><option value="28">Verse (9:28)</option><option value="29">Verse (9:29)</option><option value="30">Verse (9:30)</option><option value="31">Verse (9:31)</option><option value="32">Verse (9:32)</option><option value="33">Verse (9:33)</option><option value="34">Verse (9:34)</option><option value="35">Verse (9:35)</option><option value="36">Verse (9:36)</option><option value="37">Verse (9:37)</option><option value="38">Verse (9:38)</option><option value="39">Verse (9:39)</option><option value="40">Verse (9:40)</option><option value="41">Verse (9:41)</option><option value="42">Verse (9:42)</option><option value="43">Verse (9:43)</option><option value="44">Verse (9:44)</option><option value="45">Verse (9:45)</option><option value="46">Verse (9:46)</option><option value="47">Verse (9:47)</option><option value="48">Verse (9:48)</option><option value="49">Verse (9:49)</option><option value="50">Verse (9:50)</option><option value="51">Verse (9:51)</option><option value="52">Verse (9:52)</option><option value="53">Verse (9:53)</option><option value="54">Verse (9:54)</option><option value="55">Verse (9:55)</option><option value="56">Verse (9:56)</option><option value="57">Verse (9:57)</option><option value="58">Verse (9:58)</option><option value="59">Verse (9:59)</option><option value="60">Verse (9:60)</option><option value="61">Verse (9:61)</option><option value="62">Verse (9:62)</option><option value="63">Verse (9:63)</option><option value="64">Verse (9:64)</option><option value="65">Verse (9:65)</option><option value="66">Verse (9:66)</option><option value="67">Verse (9:67)</option><option value="68">Verse (9:68)</option><option value="69">Verse (9:69)</option><option value="70">Verse (9:70)</option><option value="71">Verse (9:71)</option><option value="72">Verse (9:72)</option><option value="73">Verse (9:73)</option><option value="74">Verse (9:74)</option><option value="75">Verse (9:75)</option><option value="76">Verse (9:76)</option><option value="77">Verse (9:77)</option><option value="78">Verse (9:78)</option><option value="79">Verse (9:79)</option><option value="80">Verse (9:80)</option><option value="81">Verse (9:81)</option><option value="82">Verse (9:82)</option><option value="83">Verse (9:83)</option><option value="84">Verse (9:84)</option><option value="85">Verse (9:85)</option><option value="86">Verse (9:86)</option><option value="87">Verse (9:87)</option><option value="88">Verse (9:88)</option><option value="89">Verse (9:89)</option><option value="90">Verse (9:90)</option><option value="91">Verse (9:91)</option><option value="92">Verse (9:92)</option><option value="93">Verse (9:93)</option><option value="94">Verse (9:94)</option><option value="95">Verse (9:95)</option><option value="96">Verse (9:96)</option><option value="97">Verse (9:97)</option><option value="98">Verse (9:98)</option><option value="99">Verse (9:99)</option><option value="100">Verse (9:100)</option><option value="101">Verse (9:101)</option><option value="102">Verse (9:102)</option><option value="103">Verse (9:103)</option><option value="104">Verse (9:104)</option><option value="105">Verse (9:105)</option><option value="106">Verse (9:106)</option><option value="107">Verse (9:107)</option><option value="108">Verse (9:108)</option><option value="109">Verse (9:109)</option><option value="110">Verse (9:110)</option><option value="111">Verse (9:111)</option><option value="112">Verse (9:112)</option><option value="113">Verse (9:113)</option><option value="114">Verse (9:114)</option><option value="115">Verse (9:115)</option><option value="116">Verse (9:116)</option><option value="117">Verse (9:117)</option><option value="118">Verse (9:118)</option><option value="119">Verse (9:119)</option><option value="120">Verse (9:120)</option><option value="121">Verse (9:121)</option><option value="122">Verse (9:122)</option><option value="123">Verse (9:123)</option><option value="124">Verse (9:124)</option><option value="125">Verse (9:125)</option><option value="126">Verse (9:126)</option><option value="127">Verse (9:127)</option><option value="128">Verse (9:128)</option><option value="129">Verse (9:129)</option></select>&nbsp;
        </div>
    </div>
</div>


<div id="mainDiv" class="container mainDevDetail">
<%--<c:forEach items="${tokens}" var="token">--%>
<%--    <div class="row border-bottom border-dark py-2">--%>
<%--        <div class="col-3">--%>
<%--            <span class="location">(${token.getChapter()}:${token.getVerse()}:${token.getToken()})</span><br><span class="phonetic">${token.getBuckwalter()}</span><br>${token.getEnglish()}--%>
<%--        </div>--%>
<%--        <div class="col-4 center-block text-center">--%>
<%--            <a name="(18:1:10)" href="/wordmorphology.jsp?location=(18:1:10)"><img src="${jstlImages}/${token.getChapter()}/${token.getImg()}.png"></a>--%>
<%--        </div>--%>
<%--        <div class="col-5">--%>
<%--            <c:set var="css" value="${fn:split(token.getCssString(),'~')}"/>--%>
<%--            <c:set var="englishGrammer" value="${fn:split(token.getEnglishGrammer(),'~')}"/>--%>
<%--            <c:set var="arabicGrammer" value="${token.getArabicGrammer()}"/>--%>
<%--            <c:forEach var="item" items="${fn:split(token.getCssStringDetail(),'~')}" varStatus="loop">--%>
<%--                <b class="${css[loop.index]}">${englishGrammer[loop.index]}</b>-${item}--%>
<%--                <br>--%>
<%--            </c:forEach>--%>
<%--            <div class="arabicGrammar">${fn:replace(arabicGrammer,"~" , "<br>")}</div>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--</c:forEach>--%>
</div>
</div>
</div>
</div>

<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-width">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                ...
            </div>
<%--            <div class="modal-footer">--%>
<%--                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>--%>
<%--                <button type="button" class="btn btn-primary">Save changes</button>--%>
<%--            </div>--%>
        </div>
    </div>
</div>
</body>
</html>
<script>
    $(document).ready(function() {
        $("#chapterList").val(chapter);
        updateVerses();
        $("#verseList").val(verse);
    });
</script>