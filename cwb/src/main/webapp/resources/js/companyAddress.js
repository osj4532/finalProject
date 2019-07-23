$(function(){
	$('.tooltips').click(function(){
		$('#optionLayer').toggleClass("ad_nested");
	});

	var toggler = $('.box');
	$(toggler).each(function(){
		$(this).click(function(){
			$(this).next().toggleClass("ad_active");
			$(this).toggleClass("check-box");
		});
	});

	$('input[name=keyword]').keyup(function(){
		ca_showList();
	});

});

function getContextPath(){
	return window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
}

function ca_showList(){
	let keyword = $('input[name=keyword]').val();
	$.ajax({
		url:getContextPath()+'/address/companySearch.do',
		type:"post",
		dataType:"json",
		data:{
			"keyword":keyword,
		},
		success:function(data){

			let ulEl = $('#result');

			if(keyword != ""){
				$('#dept').hide();
				ulEl.show();
				if(data.length == 0){
					let liEl = $('<li></li>').html("검색 결과가 없습니다.");
					ulEl.html(liEl);
				}else{
					ulEl.html("");

					for(let i = 0; i < data.length; i++){
						let map = data[i];
						let aEl = $('<a href="#"></a>')
						let liEl = $('<li></li>');
						aEl.html("["+map['DEPT_NAME']+"-"+map['POS_NAME']+"] "+map['MEM_NAME'])
						.attr("onclick","showMemInfo('"+map['MEM_NO']+"')");							
						liEl.html(aEl);
						ulEl.append(liEl);
					}
				}

			}else{
				$('#dept').show();
				ulEl.hide();
			}
		},
		error:function(xhr, status, error){
			alert(status+" : "+error);
		}
	});
};

function showMemInfo(memNo){
	$('#memInfo').modal('show');

	$.ajax({
		url:getContextPath()+'/address/memInfo.do',
		type:"post",
		data:{"memNo":memNo},
		success:function(data){
			$('.modal-body #pic').attr("src",getContextPath()+"/mem_file/"+data['MEM_FILENAME']);
			$('.modal-body #dept').html("["+data['DEPT_NAME']+"]");
			$('.modal-body #pos').html(data['POS_NAME']+" - ");
			$('.modal-body #name').html(data['MEM_NAME']);
			$('.modal-body #memNo').val(data['MEM_NO']);

			let tel = data['MEM_HP1']+"-"+data['MEM_HP2']+"-"+data['MEM_HP3'];
			$('.modal-body #tel').html("연락처 : "+tel);

			let email = data['MEM_EMAIL1']+"@"+data['MEM_EMAIL2'];
			$('.modal-body #email').html(email);
		},
		error:function(xhr, status, error){
			alert(status+" : "+error);
		}
	});
}

function openOptions(){
	let toOpen = $('#optionLayerTop');

	if($('#openText').html() == '<i class="fas fa-arrow-down"></i>'){
		$(toOpen).hide();
		$('#openText').html('<i class="fas fa-arrow-up"></i>');
	}else{
		$(toOpen).show();
		$('#openText').html('<i class="fas fa-arrow-down"></i>');
	}
};

function sendEmail(){
	let email = $('#email').html();
	open(getContextPath()+'/address/sendEmail.do?email='+email,'','width=900px, height=700px, left=200px, top=100px, location=yes, resizable=no');
}

function sendMessage(){
	let memNo = $('#memNo').val();
	open(getContextPath()+'/address/sendMessage.do?memNo='+memNo,'','width=600px, height=600px, left=200px, top=100px, location=yes, resizable=no');
}