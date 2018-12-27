<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!-- 输入框加上"X" 注意前提是已经引入了jquery "fonts"文件夹也别忘记加上了 start -->

<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" type="text/css" href="/js/bootstrap.min.css" />

<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script type="text/javascript" src="/js/bootstrap.min.js"></script>

<link type="text/css" rel="stylesheet" href="/js/ClearButton.css" charset="UTF-8" />
<script type="text/javascript" src="/js/ClearButton.js" charset="UTF-8"></script>

<!-- 输入框加上"X" end -->


<!-- 查询条件 20181203 start-->
<div class="easyui-layout" data-options="fit:true" style="margin:5px;width:auto;height: 25px;">
	<div region="north" id="queryDiv" border="false" >
		<form id="itemQuery" name="itemQuery"  onkeydown="javascript:if(event.keyCode==13)search();" action="/item/list/export" method="post">
			<div class="gd_forms">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse:separate; border-spacing:15px;">
								<tr>
								   <td height="29px" align="right" width="12%">商品ID:</td>
							       <td width="18%">
							        	<input id="id" name="id" type="text" class="input_250" style="width:200px;height: 29px;"/>
							       </td>
							       
							       <!-- 叶子类目从数据库中查询出来 -->
									<td height="29px" align="right" width="12%">叶子类目:</td>
							        <td width="18%">
								        <input id="cid" name="cid" type="text" class="easyui-combotree" style="width:200px;height: 29px;" data-options=" 
									    	    url: '/item/cat/tree',
									    	    method:'get',
									    	    checkbox:true,
									    	    lines:true,
									    	    multiple:true,
									    	    panelHeight:150,
									            panelWidth:250,
									    	    clickNodeForSpan:true, 
									                editable : true,
									                keyHandler : {
									                    query : function(q) {
									    		    var t = $(this).combotree('tree');  
									    		    var nodes = t.tree('getChildren');  
									    		    for(var i=0; i<nodes.length; i++){  
									    		        var node = nodes[i];  
									    		        if (node.text.indexOf(q) >= 0){  
									                                $(node.target).show();  
									    		        } else {  
									                                $(node.target).hide();  
									    		        }  
									    		        var opts = $(this).combotree('options');  
									    		        if (!opts.hasSetEvents){  
									                            opts.hasSetEvents = true;  
									                            var onShowPanel = opts.onShowPanel;  
									                            opts.onShowPanel = function(){  
									                            var nodes = t.tree('getChildren');  
									                            for(var i=0; i<nodes.length; i++){  
									                                $(nodes[i].target).show();  
									                            }  
									                            onShowPanel.call(this);  
									                        };  
									                        $(this).combo('options').onShowPanel = opts.onShowPanel;  
									    	        	}  
									    	        }
									    	   }
										}"/>
							       </td>
							       
							       <td height="29px" align="right" width="12%">类目状态：</td>
							        <td width="18%">
								        <select id="status" name="status" style="width: 200px;height: 29px;border-radius:4.5px;">
											<option value=""  >----请选择----</option>
											<option value=1 >正常</option>
											<option value=2 >已删除</option>
										</select>
							       </td>
									
									<td>
										<input id="query" type="button"  class="gd_btn_que"  value="查 询" style="cursor: pointer;margin-left: 20px;"  />
									</td>
								</tr>
								
								
	                            <tr>
							       <td height="29px" align="right" width="12%" >创建时间起：</td>
									<td width="18%" >
										<input type="text" id="created_start" name="created_start" style="border-radius:4.5px;" class="input_250" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'created_end\')}'})" />
									</td>
									<td height="29px" align="right" width="12%" > 至：&nbsp; </td>
									<td width="18%" >
										<input type="text" id="created_end" name="created_end" style="border-radius:4.5px;" class="input_250" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'created_start\')}'})" />
									</td>
									<td>
									</td>
									<td>
									</td>
									<td style="margin-left: 29px;">
										<input type="button" class="gd_btn_exp" id="export" value="导出excel" style="cursor:pointer;margin-left: 20px;"/>
									</td>
								</tr>
							</table>
						</div> 
					</form>
	</div>
</div>
<!-- 查询条件 20181203 end-->


<!-- 这里只是一个html片段  要分页展示商品信息 -->
<!-- data-options中singleSelect:false表示可以多选 -->
<!-- collapsible:true所代表的意思是是否显示折叠按钮，如下图最右边红色框圈住的按钮。 -->
<!-- pagination:true代表的意思是要显示分页，如果不想分页就把该值设置为false。设置成false后界面如下图所示，可以发现，与上面的图相比，没有了分页的信息。 -->
<table class="easyui-datagrid" id="itemList" title="商品列表" 
       data-options="fitColumns:true,singleSelect:false,collapsible:true,pagination:true,url:'/item/list',method:'get',pageSize:30,toolbar:toolbar">
       <!-- 下面我们来看下表头的代码，其中<thead>表示表头，<tr>表示一行。<th>表示一列。我们可以看到第一列是复选框，字段名称为"ck"，商品ID的字段名称是"id"，商品标题的字段名称为'title"等等。 -->
    <thead>
        <tr>
        	<th data-options="field:'ck',checkbox:true"></th>
        	<th data-options="field:'id',width:'5%'">商品ID</th>
            <th data-options="field:'title',width:'22%'">商品标题</th>
            <th data-options="field:'cid',width:'5%'">叶子类目</th>
            <th data-options="field:'sellPoint',width:'20%'">卖点</th>
            <th data-options="field:'price',width:'5%',align:'right',formatter:TAOTAO.formatPrice">价格</th>
            <th data-options="field:'num',width:'5%',align:'right'">库存数量</th>
            <th data-options="field:'barcode',width:'5%'">条形码</th>
            <th data-options="field:'status',width:'3%',align:'center',formatter:TAOTAO.formatItemStatus">状态</th>
            <th data-options="field:'created',width:'15%',align:'center',formatter:TAOTAO.formatDateTime">创建日期</th>
            <th data-options="field:'updated',width:'15%',align:'center',formatter:TAOTAO.formatDateTime">更新日期</th>
        </tr>
    </thead>
</table>


  <!-- 当我们从地址访问item-list时会报一个400错误，代表请求有问题，我们应该让请求转向item-list.jsp页面并且从数据库查询出数据，
转换成json返回给客户端。让datagrid进行局部刷新。由于要分页，因此还传递了page和rows，分别表示当前页码（从1开始）和每页显示多少条记录。 -->
<!-- 那么，我们服务端响应的数据格式应该是什么样子的呢？EasyUI中datagrid控件要求的数据格式为：
{total:"2",rows:[{"id":"1","name":"张三"},{"id":"2","name":"李四"}]} -->
<div id="itemEditWindow" class="easyui-window" title="编辑商品" data-options="modal:true,closed:true,iconCls:'icon-save',href:'/rest/page/item-edit'" style="width:80%;height:80%;padding:10px;">
</div>
<script>
	$(function() {
		
		//初始化商品ID combobox
		initID();
		
		//商品列表的查询按钮绑定一个事件
		$('#query').bind('click', function() {
			search();
		});
		
		$('#export').bind('click',function(){$("#itemQuery").submit()});
		
	});
	
	
    function getSelectionsIds(){
    	var itemList = $("#itemList");
    	var sels = itemList.datagrid("getSelections");
    	var ids = [];
    	for(var i in sels){
    		ids.push(sels[i].id);
    	}
    	ids = ids.join(",");
    	return ids;
    }
    
    /* 定义一些工具栏 */
    var toolbar = [{
        text:'新增',
        iconCls:'icon-add',
        handler:function(){
        	$(".tree-title:contains('新增商品')").parent().click();
        }
    },{
        text:'编辑',
        iconCls:'icon-edit',
        handler:function(){
        	var ids = getSelectionsIds();
        	if(ids.length == 0){
        		$.messager.alert('提示','必须选择一个商品才能编辑!');
        		return ;
        	}
        	if(ids.indexOf(',') > 0){
        		$.messager.alert('提示','只能选择一个商品!');
        		return ;
        	}
        	
        	$("#itemEditWindow").window({
        		onLoad :function(){
        			//回显数据
        			var data = $("#itemList").datagrid("getSelections")[0];
        			data.priceView = TAOTAO.formatPrice(data.price);
        			$("#itemeEditForm").form("load",data);
        			
        			// 加载商品描述
        			$.getJSON('/rest/item/query/item/desc/'+data.id,function(_data){
        				if(_data.status == 200){
        					//UM.getEditor('itemeEditDescEditor').setContent(_data.data.itemDesc, false);
        					itemEditEditor.html(_data.data.itemDesc);
        				}
        			});
        			
        			//加载商品规格
        			$.getJSON('/rest/item/param/item/query/'+data.id,function(_data){
        				if(_data && _data.status == 200 && _data.data && _data.data.paramData){
        					$("#itemeEditForm .params").show();
        					$("#itemeEditForm [name=itemParams]").val(_data.data.paramData);
        					$("#itemeEditForm [name=itemParamId]").val(_data.data.id);
        					
        					//回显商品规格
        					 var paramData = JSON.parse(_data.data.paramData);
        					
        					 var html = "<ul>";
        					 for(var i in paramData){
        						 var pd = paramData[i];
        						 html+="<li><table>";
        						 html+="<tr><td colspan=\"2\" class=\"group\">"+pd.group+"</td></tr>";
        						 
        						 for(var j in pd.params){
        							 var ps = pd.params[j];
        							 html+="<tr><td class=\"param\"><span>"+ps.k+"</span>: </td><td><input autocomplete=\"off\" type=\"text\" value='"+ps.v+"'/></td></tr>";
        						 }
        						 
        						 html+="</li></table>";
        					 }
        					 html+= "</ul>";
        					 $("#itemeEditForm .params td").eq(1).html(html);
        				}
        			});
        			
        			TAOTAO.init({
        				"pics" : data.image,
        				"cid" : data.cid,
        				fun:function(node){
        					TAOTAO.changeItemParam(node, "itemeEditForm");
        				}
        			});
        		}
        	}).window("open");
        }
    },{
        text:'删除',
        iconCls:'icon-cancel',
        handler:function(){
        	var ids = getSelectionsIds();
        	if(ids.length == 0){
        		$.messager.alert('提示','未选中商品!');
        		return ;
        	}
        	$.messager.confirm('确认','确定删除ID为 '+ids+' 的商品吗？',function(r){
        	    if (r){
        	    	var params = {"ids":ids};
                	$.post("/rest/item/delete",params, function(data){
            			if(data.status == 200){
            				$.messager.alert('提示','删除商品成功!',undefined,function(){
            					$("#itemList").datagrid("reload");
            				});
            			}
            		});
        	    }
        	});
        }
    },'-',{
        text:'下架',
        iconCls:'icon-remove',
        handler:function(){
        	var ids = getSelectionsIds();
        	if(ids.length == 0){
        		$.messager.alert('提示','未选中商品!');
        		return ;
        	}
        	$.messager.confirm('确认','确定下架ID为 '+ids+' 的商品吗？',function(r){
        	    if (r){
        	    	var params = {"ids":ids};
                	$.post("/rest/item/instock",params, function(data){
            			if(data.status == 200){
            				$.messager.alert('提示','下架商品成功!',undefined,function(){
            					$("#itemList").datagrid("reload");
            				});
            			}
            		});
        	    }
        	});
        }
    },{
        text:'上架',
        iconCls:'icon-remove',
        handler:function(){
        	var ids = getSelectionsIds();
        	if(ids.length == 0){
        		$.messager.alert('提示','未选中商品!');
        		return ;
        	}
        	$.messager.confirm('确认','确定上架ID为 '+ids+' 的商品吗？',function(r){
        	    if (r){
        	    	var params = {"ids":ids};
                	$.post("/rest/item/reshelf",params, function(data){
            			if(data.status == 200){
            				$.messager.alert('提示','上架商品成功!',undefined,function(){
            					$("#itemList").datagrid("reload");
            				});
            			}
            		});
        	    }
        	});
        }
    }];
    
    function search(){
    	//序列化查询条件
		var query=$("#itemQuery").serializeObject();
		
		if(!query.created_start){
			delete query.created_start;
		}
		if(!query.created_end){
			delete query.created_end;
		}
		
		
		/* //获取当前combotree的tree对象
		var tree = $('#cid').combotree('tree'); 
		//获取当前选中的节点
		var data = tree.tree('getSelected'); 
		alert(data.id);
		//设置叶子类目下拉树的值
		$('#cid').combotree('setValue',data.id); */
		
		
		//writeObj(query);
		var cid="";
		
		//alert("value:"+$("#cid").combotree('getValue'));
		//alert("text:"+$("#cid").combotree('getText'));
		
		var cname = $("#cid").combotree('getText');//叶子类目输入框显示内容
		
		if (cname !== null && cname !== undefined && cname !== '') { 
			cid = $("#cid").combotree("getValues");
			cid = cid.join(',');//若是多选那么这里要将数组迭代转成String，easyui会自动改变提交参数的类型变为数组，导致后台属性为String时拿不到值。
		}
		
		//注意总结js判断不为空的方法 https://www.cnblogs.com/daysme/p/6979231.html
		
		//var id = $("#id").val();
		var id = $('#id').combobox('getValue');//获取当前选中的值
		//id有可能在导出excel提交表单的时候获取不到值需要处理一下20181214  刚开始参数都是空的 直接导出excel没事  如果点击了查询按钮后就需要将这些combobox的值赋值给input标签 才能在提交表单的时候能获取到
		
		$('#id').val(id);
		$('#cid').val(cid);
		
		//$('#id').combobox('getText');//获取当前选中的文字
		//alert("id:"+id);
		var status = $("#status").val();
		var created_start = $("#created_start").val();
		var created_end = $("#created_end").val();
		//alert("叶子类目："+cid);
		
		//数组转字符串
		//var a, b,c; 
		//a = new Array(a,b,c,d,e); 
		//b = a.join('-'); //a-b-c-d-e  使用-拼接数组元素
		//c = a.join(''); //abcde
		//若是多选那么这里要将数组迭代转成String，easyui会自动改变提交参数的类型变为数组，导致后台属性为String时拿不到值。
		//cid = cid.join(',');
		
		
		//字符串转数组
		//var str = 'ab+c+de';
		//var a = str.split('+'); // [ab, c, de]
		//var b = str.split(''); //[a, b, +, c, +, d, e]
		
		$('#itemList').datagrid('load',{
			//queryParams: query 这里需要使用具体的参数
			id:id,
			cid:cid,
			status:status,
			created_start:created_start,
			created_end:created_end
		});
		
		/* $('#appment').datagrid({
			queryParams: query,
			url:"${contextPath}${navigation['INTERFACE_STATUS_GET']}" 
		}); */
	}
	

	//打印object(常用工具)
	function writeObj(obj) {
		var description = "";
		for ( var i in obj) {
			var property = obj[i];
			description += i + " = " + property + "\n";
		}
		alert(description);
	}

	//初始化商品ID combobox
	function initID() {
		$('#id').combobox({
			url : "/item/id",
			method : 'post',
			mode : 'remote',//从服务器接收数据，用户输入的数据以名为q的参数传至后台  local是先加载所有的
			valueField : 'id',
			textField : 'id',//filter 实现模糊查询
			filter : function(q, row) {
				console.log(q);
				var opts = $(this).combobox('options');
				return row[opts.textField].indexOf(q) > -1;
			}
		});
	}
	
	
</script>