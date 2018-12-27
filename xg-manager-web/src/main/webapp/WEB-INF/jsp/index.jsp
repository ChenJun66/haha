<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商城后台管理系统</title>
<link rel="stylesheet" type="text/css" href="js/jquery-easyui-1.4.1/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="js/jquery-easyui-1.4.1/themes/icon.css" />
<link rel="stylesheet" type="text/css" href="css/taotao.css" />
<script type="text/javascript" src="js/jquery-easyui-1.4.1/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/jquery-easyui-1.4.1/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>


<!-- 输入框加上"X" 注意前提是已经引入了jquery "fonts"文件夹也别忘记加上了 start -->
<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" type="text/css" href="js/bootstrap.min.css" />

<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script type="text/javascript" src="js/bootstrap.min.js"></script>

<link type="text/css" rel="stylesheet" href="js/ClearButton.css" charset="UTF-8" />
<script type="text/javascript" src="js/ClearButton.js" charset="UTF-8"></script>
<!-- 输入框加上"X" end -->

</head>

<body class="easyui-layout">
    <div data-options="region:'west',title:'菜单',split:true" style="width:180px;">
    	<ul id="menu" class="easyui-tree" style="margin-top: 10px;margin-left: 5px;">
         	<li>
         		<span>商品管理</span>
         		<ul>
	         		<li data-options="attributes:{'url':'item-add'}">新增商品</li>
	         		<li data-options="attributes:{'url':'item-list'}">查询商品</li>
	         		<li data-options="attributes:{'url':'item-param-list'}">规格参数</li>
	         	</ul>
         	</li>
         	<li>
         		<span>网站内容管理</span>
         		<ul>
	         		<li data-options="attributes:{'url':'content-category'}">内容分类管理</li>
	         		<li data-options="attributes:{'url':'content'}">内容管理</li>
	         	</ul>
         	</li>
         	<li>
         		<span>索引库管理</span>
         		<ul>
	         		<li data-options="attributes:{'url':'import-index'}">导入索引库</li>
	         	</ul>
         	</li>
         </ul>
    </div>
    <div data-options="region:'center',title:''">
    	<div id="tabs" class="easyui-tabs">
		    <div title="首页" style="padding:20px;">
			</div>
		</div>
    </div>
    
<script type="text/javascript">


	//定义serializeObject方法，序列化表单
	$.fn.serializeObject = function() {
		var o = {};
		var a = this.serializeArray();
		$.each(a, function() {
			if (o[this.name]) {
				if (!o[this.name].push) {
					o[this.name] = [ o[this.name] ];
				}
				o[this.name].push(this.value || '');
			} else {
				o[this.name] = this.value || '';
			}
		});
		return o;
	};

	$(function() {
		$('#menu').tree({
			onClick : function(node) {
				if ($('#menu').tree("isLeaf", node.target)) {
					var tabs = $("#tabs");
					var tab = tabs.tabs("getTab", node.text);
					if (tab) {
						tabs.tabs("select", node.text);
					} else {
						tabs.tabs('add', {
							title : node.text,
							href : node.attributes.url,
							closable : true,
							bodyCls : "content"
						});
					}
				}
			}
		});

	});
</script>
</body>
</html>