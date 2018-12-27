<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="easyui-panel" title="Nested Panel" data-options="width:'100%',minHeight:500,noheader:true,border:false" style="padding:10px;">
    <div class="easyui-layout" data-options="fit:true">
        <div data-options="region:'west',split:false" style="width:250px;padding:5px">
            <ul id="contentCategoryTree" class="easyui-tree" data-options="url:'/content/category/list',animate: true,method : 'GET'">
            </ul>
        </div>
        <div data-options="region:'center'" style="padding:5px">
        	<!-- "toolbar:contentListToolbar"这么一句代码，这句代码的意思是定义了工具栏，工具栏中有多个功能。 -->
            <table class="easyui-datagrid" id="contentList" data-options="toolbar:contentListToolbar,singleSelect:false,collapsible:true,pagination:true,method:'get',pageSize:20,url:'/content/query/list',queryParams:{categoryId:0}">
		    <thead>
		        <tr>
		            <th data-options="field:'id',width:30">ID</th>
		            <th data-options="field:'title',width:120">内容标题</th>
		            <th data-options="field:'subTitle',width:100">内容子标题</th>
		            <th data-options="field:'titleDesc',width:120">内容描述</th>
		            <th data-options="field:'url',width:60,align:'center',formatter:TAOTAO.formatUrl">内容连接</th>
		            <th data-options="field:'pic',width:50,align:'center',formatter:TAOTAO.formatUrl">图片</th>
		            <th data-options="field:'pic2',width:50,align:'center',formatter:TAOTAO.formatUrl">图片2</th>
		            <th data-options="field:'created',width:130,align:'center',formatter:TAOTAO.formatDateTime">创建日期</th>
		            <th data-options="field:'updated',width:130,align:'center',formatter:TAOTAO.formatDateTime">更新日期</th>
		        </tr>
		    </thead>
		</table>
        </div>
    </div>
</div>
<script type="text/javascript">
$(function(){
	var tree = $("#contentCategoryTree");//获取内容分类树
	var datagrid = $("#contentList");//是获取内容列表，
	/* 这段代码的意思是当我们点击左边内容分类树的某个节点时，会做下判断，判断是不是叶子节点
	，如果是叶子节点那么就给categoryId赋值为这个叶子节点的id并且会重新加载内容列表，
	也就意味着重新发起url:'/content/query/list'请求，只是这时的参数queryParams:中categoryId的值变成了单个叶子节点的id。 */

	tree.tree({
		onClick : function(node){
			if(tree.tree("isLeaf",node.target)){
				datagrid.datagrid('reload', {
					categoryId :node.id
		        });
			}
		}
	});
});
var contentListToolbar = [{
    text:'新增',
    iconCls:'icon-add',
    /* handler:function()则是当我们点击"新增"按钮时触发的函数 */
    handler:function(){
    	/* 得到用户选中的内容分类节点 */
    	var node = $("#contentCategoryTree").tree("getSelected");
    	/* if(!node || !$("#contentCategoryTree").tree("isLeaf",node.target)){的意思是如果没有选中的不是节点或者该节点不是叶子节点，那么就弹出提示"新增内容必须选择一个内容分类!"。 */
    	if(!node || !$("#contentCategoryTree").tree("isLeaf",node.target)){
    		$.messager.alert('提示','新增内容必须选择一个内容分类!');
    		return ;
    	}
    	//如果点击的是叶子节点的话，就会调用common.js当中定义的TT的createWindow方法初始化一个弹出框，弹出框中显示的页面是参数指定的url: 
    	//"/content-add"也就是content-add.jsp页面。
    	//注意弹框的方式
    	TT.createWindow({
			url : "/content-add"
		}); 
    }
},{
    text:'编辑',
    iconCls:'icon-edit',
    handler:function(){
    	/* 获取内容列表的所有id的集合 */
    	var ids = TT.getSelectionsIds("#contentList");
    	if(ids.length == 0){
    		$.messager.alert('提示','必须选择一个内容才能编辑!');
    		return ;
    	}
    	/* 如果选择的内容多于一个的话也弹出警告 */
    	if(ids.indexOf(',') > 0){
    		$.messager.alert('提示','只能选择一个内容!');
    		return ;
    	}
    	
    	/* 初始一个弹出窗口 */
    	var number = 0; 
		TT.createWindow({
			/* url : "/content-edit"的意思是在弹出框中加载的是content-edit.jsp页面 */
			url : "/content-edit",
			/* onLoad : function()里面的内容都是初始化编辑界面的数据。*/
			onLoad : function(){
				/* 使用了一个临时变量来记录调用次数如果是第二次调用的话，则直接返回，不做下面的操作 */
				number = number +1;  
                if(number == 2){  
                    return;  
                } 
                //下面这行是之前的写法
				//var data = $("#contentList").datagrid("getSelections")[0];
				var node = $("#contentList").datagrid("getSelections")[0];
				var params={"id":node.id};
				$.get("/content/getContent",params, function(data){  
                    if(data.status == 200){  
                        //debugger就如同断点一样
                    	debugger  
                        node = data.data; 
				//$("#contentEditForm").form("load",data);
				$("#contentEditForm").form("load",node);
				
				// 实现图片  回显，并且在图片上绑定一个链接使可以点击
				if(node.pic){
					$("#contentEditForm [name=pic]").after("<a href='"+node.pic+"' target='_blank'><img src='"+node.pic+"' width='80' height='50'/></a>");	
				}
				if(node.pic2){
					$("#contentEditForm [name=pic2]").after("<a href='"+node.pic2+"' target='_blank'><img src='"+node.pic2+"' width='80' height='50'/></a>");					
				}
				
				contentEditEditor.html(node.content);
                    }  
	              });  
	            }  
	        });    	
    }
},{
    text:'删除',
    iconCls:'icon-cancel',
    handler:function(){
    	var ids = TT.getSelectionsIds("#contentList");
    	if(ids.length == 0){
    		$.messager.alert('提示','未选中商品!');
    		return ;
    	}
    	//删除的时候需要给予提示
    	$.messager.confirm('确认','确定删除ID为 '+ids+' 的内容吗？',function(r){
    	    if (r){
    	    	var params = {"ids":ids};
            	$.post("/content/delete",params, function(data){
        			if(data.status == 200){
        				$.messager.alert('提示','删除内容成功!',undefined,function(){
        					$("#contentList").datagrid("reload");
        				});
        			}
        		});
    	    }
    	});
    }
}];

</script>