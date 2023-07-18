<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta charset="utf-8">
<title>CSS</title>

<style type="text/css">
*{margin:0;padding:0;}li{list-style-type:none;}
img, fieldset{border:none;}li img, dd img{vertical-align:top;}
   @font-face{font-family:'NGothic'; src:url('font/NanumGothic.woff') format('woff');}
   @font-face{font-family:'NGothicB'; src:url('font/NanumGothicBold.woff') format('woff');}
   @font-face{font-family:'NGothicEB'; src:url('font/NanumGothicExtraBold.woff') format('woff');}

body{font:13px "NGothic",Arial;background:#aaa;}

/* Layout */
#wrapper{width:800px;margin:0 auto;background:#fff;}
#header{text-align:center;background:#fa0;color:#fff;}
#container{float:left;width:100%;}
.cover{float:left;width:600px;}
.content{float:right;width:400px;background:#ddd;color:#123456;}
.sidemenu{float:left;width:200px;}
.aside{float:right;width:200px;}
#footer{clear:both;}

/* Detail */
a{font-weight:bold;}
a:hover{border-bottom:1px dashed;}

h1{font-size:800%;}
h1 span{display:block;font-size:20px;padding-bottom:10px;}
.stit{background:#ccc;color:#333;padding:5px;}

.content dt a{display:block;color:#ddd;font:bold 130% "NGothic",Arial;
		padding:5px;text-decoration:none;background:#123456;}
.content dt + dd{font-weight:bold;font-size:120%;}

.sidemenu dt{font:bold 130% "NGothic",Arial;background:#900;color:#fff;}
.sidemenu a{color:#000;}

.aside dt{font:bold 170% "NGothic",Arial;color:#999;}
.aside dt .all{text-decoration:underline;}
.aside dt .love{color:#fa0;border-bottom:1px solid #fa0;}
.aside dt strong{color:#333;/*border:none;*/}
.aside a{color:#000;}
.aside span{display:block;}

dt,dd{padding:10px;}
address{font:bold normal 100% "NGothic",Arial;padding:10px;
		background:#123456;color:#eee;text-align:center;}
address a{color:#eee;}

</style>
</head>

<body>
  <div id="wrapper">
		<div id="header">
			<h1>Musée d'Orsay<span>Musée d'Orsay Musée d'Orsay 
				Musée d'Orsay Musée d'Orsay Musée d'Orsay</span>
			</h1>
			<p class="stit">Royal Academy of Arts, <span>THE REAL VANGOGH
					</span> THE ARTIST AND HIS LETTERS</p>
		</div>
		<div id="container">
			<div class="cover">
			<div class="content">
				<dl>
					<dt>피리부는 소년</dt>
					<dd>에두아르마네</dd>
					<dd>1866 캔버스에 유채, 161*97cm, 파리 오르세 Edouard MANET, Le Fifre, H.T, 161*97cm</dd>
				</dl>
				<dl>
					<dt>고흐의 방</dt>
					<dd class="artist">빈센트반고흐</dd>
					<dd>1889 캔버스에 유채,57.5*74cm,파리 오르세	Vincent Van GOGH,La Chambre de Van Gogh, H/T, 57.5*74cm	</dd>
				</dl>
				<dl>
					<dt>황색 그리스도가 있는 화가의 자화상</dt>
					<dd class="artist">폴 고갱</dd>
					<dd>1890-1891 캔버스에 유채,38*46cm,파리 오르세 Paul Gauguin Portrait de I'artiste au Paul Gauguin, H/T, 38*46cm</dd>
				</dl>
				<dl>
					<dt>오페라좌의 관현악단</dt>
					<dd class="artist">에드가 드가</dd>
					<dd>1868-1869 캔버스에 유채,32*46cm,파리 오르세 Edgar Degas, L'orchestre de I'Opera H/T, 38*46cm</dd>
				</dl>		
				<dl>
					<dt>만종</dt>
					<dd class="artist">장 프랑수아 밀레</dd>
					<dd>1857-1859 캔버스에 유채,55.5*66cm,파리 오르세 Jean-Franqois Millet, L'Angelus H/T, 55.5*66cm</dd>
				</dl>
				<dl>
					<dt>제비꽃장식을 단 베르트모리조</dt>
					<dd class="artist">에두아르마네</dd>
					<dd>1872 Eduouard Manet Berthe Morisot au bouquet de H/T, 55*38cm</dd>
				</dl>
			</div>

			<dl class="sidemenu">
				<dt>ARTIST</dt>
				<dd>작가의 작품</dd>
				<dd>작가의 시대</dd>
				<dd>작가의 일생</dd>
			</dl>
			</div>

			<dl class="aside">
				<dt><span class="all">전세계인들에게</span><span class="love">제일 사랑받는</span><strong>서양미술사의 시대</strong></dt>
				<dd>Workshop Go <span>Life drowing workshop</span></dd>
				<dd>Summer exhibition <span>A-level Summer Exibition Online 2010</span></dd>
				<dd>RA collection <span>RA Collections</span></dd>
			</dl>
		</div>

		<div id="footer">
			<address>©  2012 Les Amis du Musée d'Orsay. All rights reserved. 
				amis@amis-musee-orsay.org
				<span>Legal status</span>
			</address>
		</div>

  </div>
</body>
</html>