
	var contextPath = "/finalproject";
	$(document).ready(function(){
		$('input[name=memEmail2]').change(function(){
			if($(this).val()=="etc"){
				$('input[name=memEmail3]').css('visibility', 'visible');
				$('input[name=memEmail3]').focus();
			}else{
				$('input[name=memEmail3]').css('visibility', 'hidden');
				$('input[name=memEmail3]').val("");
			}
		});
		
	});
	
	function validate_hp(hp){
		var pattern = new RegExp(/^[0-9]*$/g);
		return pattern.test(hp);
		/* 정규식 /^[0-9]*$/g
		0 에서 9사이의 숫자로 시작하거나 끝나야 한다는 의미
		(^는 시작, $는 끝을 의미)
		닫기 대괄호(]) 뒤의 * 기호는 0번 이상 반복 */
	}
	
	function validate_userid(userid){
		var pattern = new RegExp(/^[a-zA-Z0-9_]/g);
		return pattern.test(userid);
		/* 정규식 /^[a-zA-Z0-9_]+$/g
		a에서 z 사이의 문자, A~Z사이의 문자, 0에서 9사이의 숫자나 _로 시작하거나
		끝나야 한다는 의미
		닫기 대괄호(]) 뒤의 + 기호는 이 패턴이 한 번 또는 그 이상 반복된다는 의미 */
	}