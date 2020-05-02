<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Asiakkaiden listaus</title>
</head>
<body>
	<table id="listaus">
		<thead>	
			<tr>
				<th colspan="2" class="oikealle">Hakusana:</th>
				<th><input type="text" id="hakusana"></th>
				<th><input type="button" id="hae" value="Hae"></th>
			</tr>		
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>Sposti</th>	
				<th></th>			
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
<script>
$(document).ready(function(){
	
	$("#uusiAsiakas").click(function(){
		document.location="lisaaasiakas.jsp";
	});
	
	$(document.body).on("keydown", function(event){
		  if(event.which==13){ 							//Enteriä painettu, ajetaan haku
			  haeTiedot();
		  }
	});	
	$("#hae").click(function(){	
		haeTiedot();
	});
	$("#hakusana").focus();								//viedään kursori hakusana-kenttään sivun latauksen yhteydessä
	haeTiedot();
});
function haeTiedot(){	
	$("#listaus tbody").empty();
	$.getJSON({url:"asiakkaat/"+$("#hakusana").val(), type:"GET", dataType:"json", success:function(result){	
		$.each(result.asiakkaat, function(i, field){  
        	var htmlStr;
        	htmlStr+="<tr>"; 
        	htmlStr+="<td>"+field.etunimi+"</td>";
        	htmlStr+="<td>"+field.sukunimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";
        	htmlStr+="<td>"+field.sposti+"</td>";   
        	htmlStr+="<td><span class='poista' onclick=poista('"+field.etunimi+"')>Poista</span></td>";
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);
        });
    }});	
}
function poista(rekno){
	if(confirm("Poista asiakas " + etunimi +"?")){
		$.ajax({url:"asiakkaat/"+etunimi, type:"DELETE", dataType:"json", success:function(result) {
	        if(result.response==0){
	        	$("#ilmo").html("Asiakkaan poisto epäonnistui.");
	        }else if(result.response==1){
	        	$("#rivi_"+etunimi).css("background-color", "red"); 
	        	alert("Asiakkaan " + etunimi +" poisto onnistui.");
				haeAsiakkaat();        	
			}
	    }});
	}
}
</script>
</body>
</html>