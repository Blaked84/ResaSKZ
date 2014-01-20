function add_to_commande(commande_id, product_id_var){
	$.post({
		type: "POST",
		url: "/commandes/1/add_product",
		data: {product_id : product_id_var}
	})
};


