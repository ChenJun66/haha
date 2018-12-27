<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div>
	 <!-- 展示内容分类树 -->
	 <ul id="contentCategory" class="easyui-tree">
     </ul>
</div>
<div id="contentCategoryMenu" class="easyui-menu" style="width:120px;" data-options="onClick:menuHandler">
    <div data-options="iconCls:'icon-add',name:'add'">添加</div>
    <div data-options="iconCls:'icon-remove',name:'rename'">重命名</div>
    <div class="menu-sep"></div>
    <div data-options="iconCls:'icon-remove',name:'delete'">删除</div>
</div>

<script type="text/javascript">
$(function(){
	$("#contentCategory").tree({
		url : '/content/category/list',
		/* animate:true的意思是设置动画，如果设置为true，展开树形结构时是慢慢展开的效果。 */
		animate: true,
		method : "GET",
		/* 这行代码的意思是当我们鼠标点击右键的时候触发该js方法方法的参数中"e"代表事件，node代表鼠标在哪个节点上。 */
		/* e.preventDefault();代表事件传递 */
		/* $(this).tree('select',node.target);这行代码的意思是$(this)指定鼠标所在的节点转变为jquery对象 */
		/* .tree('select',node.target);意思是选中这个节点（node这行会添加背景颜色）。 */
		onContextMenu: function(e,node){
            e.preventDefault();
            $(this).tree('select',node.target);
            /* $('#contentCategoryMenu').menu('show'{这行代码的意思是让右键菜单显示出来，下面的left和top是指坐标 */
            $('#contentCategoryMenu').menu('show',{
                left: e.pageX,
                top: e.pageY
            });
        },
        /* 实际进行添加节点到数据库的操作 */
        onAfterEdit : function(node){
        	var _tree = $(this);
        	/* if(node.id == 0){的意思是如果node的id是0（我们新建的节点id就暂时是0，因此会进入这个if当中） */
        	if(node.id == 0){
        		// 新增节点{parentId:node.parentId,name:node.text}是指传递的参数有两个，分别是父级id和节点的名称。
        		/*function(data)是回调函数，data是返回的对象*/
        		$.post("/content/category/create",{parentId:node.parentId,name:node.text},function(data){
        			if(data.status == 200){
        				_tree.tree("update",{
            				target : node.target,
            				id : data.data.id
            			});
        			}else{
        				$.messager.alert('提示','创建'+node.text+' 分类失败!');
        			}
        		});
        	}else{
        		$.post("/content/category/update",{id:node.id,name:node.text});//重命名  如果你是新增的话只能明确知道那个节点的父节点 而重命名的话就能知道当前这个极爱单那是哪个了
        	}
        }
	});
});
/* 上面有个点击事件	 */
function menuHandler(item){
	/* 这行代码当然就是获取分类树了 */
	var tree = $("#contentCategory");
	/* 这行代码是获取选中的节点 */
	var node = tree.tree("getSelected");
	if(item.name === "add"){
		/* tree.tree('append',{这行代码的意思是我们点击"添加"的时候会在这个节点下面追加一个节点 */
		tree.tree('append', {
			/* parent: (node?node.target:null),是为新节点指定父节点   这里已经将当前节点指定为新增的节点的父节点了 所以后面就能直接使用了*/
			parent: (node?node.target:null),
			/* data里面的text是指新建的节点名称叫"新建分类"id:0，表示新建的节点暂时定义id为0，parentId:node.id是指新建节点的parentId是我们操作的节点 */
            data: [{
                text: '新建分类',
                id : 0,
                parentId : node.id
            }]
        }); 
		/* var _node = tree.tree('find',0)的意思是在树种找到id为0的节点（由于新建的节点暂时定义id为0，因此会找到刚添加的节点） */
		var _node = tree.tree('find',0);
		/* 这行代码的意思是让新建的节点处于可编辑状态可以看到实际添加节点的操作不在menuHandler这个方法中，这个方法真正执行的操作是删除节点， */
		tree.tree("select",_node.target).tree('beginEdit',_node.target);
	}else if(item.name === "rename"){
		tree.tree('beginEdit',node.target);
	}else if(item.name === "delete"){
		$.messager.confirm('确认','确定删除名为 '+node.text+' 的分类吗？',function(r){
			if(r){
				/* 传递的参数是父级id和要删除的节点的idfunction()是指回调函数，tree.tree("remove",node.target);意思就是从树形结构中删掉这个节点 */
				/* 为什么删除节点需要传递他的父级ID,因为你删除了一个节点，它的父节点的状态需要改变 */
				/* $.post("/content/category/delete/",{parentId:node.parentId,id:node.id},function(){ */
				/* 做完了内容分类添加下面我们实现以下内容分类修改和删除，其中我们需要先修改下content-category.jsp页面的删除请求的参数，
				因为树形结构的节点只有id、name、sate三个属性，并没有parentId属性，只有新增的节点给parentId赋值了，
				对于页面刚加载完的树形目录，节点是没有parentId属性的，因此我们把parentId这个参数去掉，我们只通过节点id便可以删除节点了。
				删除parentId参数后变为"$.post("/content/category/delete/",{id:node.id},function(){"	 */
				$.post("/content/category/delete",{id:node.id},function(){
					tree.tree("remove",node.target);
				});	
			}
		});
	}
}
</script>