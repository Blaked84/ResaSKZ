function add_to_commande(commande_id, product_id_var){
	$.ajax({
		type: "POST",
		dataType: 'json',
		url: "/commandes/"+commande_id+"/add_product",
		data: {product_id : product_id_var}
	})
	check_nombre_cp(commande_id, product_id_var);
};

function remove_to_commande(commande_id, product_id_var){
	$.ajax({
		type: "POST",
		dataType: 'json',
		url: "/commandes/"+commande_id+"/remove_product",
		data: {product_id : product_id_var}
	})
	check_nombre_cp(commande_id, product_id_var);
};

function check_nombre_cp(commande_id_var, product_id_var){
	$.ajax({
		type: "POST",
		dataType: 'json',
		url: "/commande_products/check_nombre",
		data: {commande_id: commande_id_var,product_id : product_id_var},
		success : function( data ) {
  			$('#product'+product_id_var).html(data)
  		},
  		error: function( data ) {
  			alert( 'ERROR' );
  		}
  	});
};


function maj_cat_product(commande_id, cat_id){
   	
   	value = $('#choix_cat'+cat_id).val();

   	$.ajax({
		type: "POST",
		dataType: 'json',
		url: "/commandes/"+commande_id+"/maj_cat_product",
		data: {product_id : value, categorie_id: cat_id}
	})

};

