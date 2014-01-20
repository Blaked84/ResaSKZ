function add_to_commande(commande_id, product_id_var){
	$.ajax({
		type: "POST",
		dataType: 'json',
		url: "/commandes/"+commande_id+"/add_product",
		data: {product_id : product_id_var}
	})
};


