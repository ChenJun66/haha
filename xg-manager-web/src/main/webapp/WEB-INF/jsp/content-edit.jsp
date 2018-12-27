<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="/js/kindeditor-4.1.10/themes/default/default.css" type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="/js/kindeditor-4.1.10/kindeditor-all-min.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/kindeditor-4.1.10/lang/zh_CN.js"></script>
<div style="padding:10px 10px 10px 10px">
	<form id="contentEditForm" class="itemForm" method="post">
		<input type="hidden" name="categoryId"/>
		<input type="hidden" name="id"/>
	    <table cellpadding="5">
	        <tr>
	            <td>内容标题:</td>
	            <td><input class="easyui-textbox" type="text" name="title" data-options="required:true" style="width: 280px;"></input></td>
	        </tr>
	        <tr>
	            <td>内容子标题:</td>
	            <td><input class="easyui-textbox" type="text" name="subTitle" style="width: 280px;"></input></td>
	        </tr>
	        <tr>
	            <td>内容描述:</td>
	            <td><input class="easyui-textbox" name="titleDesc" data-options="multiline:true,validType:'length[0,150]'" style="height:60px;width: 280px;"></input>
	            </td>
	        </tr>
	         <tr>
	            <td>URL:</td>
	            <td><input class="easyui-textbox" type="text" name="url" style="width: 280px;"></input></td>
	        </tr>
	        <tr>
	            <td>图片:</td>
	            <td>
	                <input type="hidden" name="pic" />
	                <a href="javascript:void(0)" class="easyui-linkbutton onePicUpload">图片上传</a>
	            </td>
	        </tr>
	        <tr>
	            <td>图片2:</td>
	            <td>
	            	<input type="hidden" name="pic2" />
	            	<a href="javascript:void(0)" class="easyui-linkbutton onePicUpload">图片上传</a>
	            </td>
	        </tr>
	        <tr>
	            <td>内容:</td>
	            <td>
	                <textarea style="width:800px;height:300px;visibility:hidden;" name="content"></textarea>
	            </td>
	        </tr>
	    </table>
	</form>
	<div style="padding:5px">
	    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="contentEditPage.submitForm()">提交</a>
	    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="contentEditPage.clearForm()">重置</a>
	</div>
</div>
<script type="text/javascript">

/* 然后我们看下content-edit.jsp页面，表格中的字段与数据库中Tbcontent表是一致的，
下面的js代码跟内容添加很相似，页面加载完之后初始化富文本编辑器，并且设置成单图片上传。
点提交后先检查表单的内容是否合法，如果不合法则弹出警告。如果合法，那么用富文本编辑器的数据会与表单中的字段值进行同步，
然后发起url为/rest/content/edit的请求，将表单中的数据序列化为key-value形式的字符串。在回调函数中判断操作是否成功，
如果操作成功那么重新加载内容列表然后关闭弹出窗口 */

var contentEditEditor ;
//页面加载完就执行
$(function(){
	contentEditEditor = TT.createEditor("#contentEditForm [name=content]");
	TT.initOnePicUpload();
});

var contentEditPage = {
		submitForm : function(){
			if(!$('#contentEditForm').form('validate')){
				$.messager.alert('提示','表单还未填写完成!');
				return ;
			}
			//利用富文本编辑器的数据与表单中的字段值进行同步
			contentEditEditor.sync();
			debugger
			 $.post("/rest/content/edit",$("#contentEditForm").serialize(), function(data){  
	                if(data.status == 200){  
	                    TT.closeCurrentWindow();  
	                    $("#contentList").datagrid("reload");  
	                    $.messager.alert('提示','修改内容成功!');  
	                }  
	         });  
		},
		clearForm : function(){
			
		}
};

</script>