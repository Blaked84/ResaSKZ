$(document).ready(function() {
    $('select').material_select();
  });

 $(function() {

	$(document).ready(function() {
        // Sections height

            var sH = $(window).height() + 30;
            $('.img_fullscreen').css('height', sH + 'px');
			$('.img_fullscreen').css('width', $(window).width());
			$('.sfullscreen').css('min-height', sH + 'px');
			$('.sfullscreen').css('width', $(window).width());
			$('iframe').css('height', sH*0.70 + 'px');
			$('iframe').css('width', $(window).width() * 0.7 + 'px');

			/*var options = [{selector: '#monpack_infos', offset: 500, callback:
						function(el) { Materialize.showStaggeredList($(el)); } }}];
			Materialize.scrollFire(options); */
			var options = [
		{selector: '#mon_pack', offset: 300, callback: function(el){Materialize.showStaggeredList('#monpack_infos');}},
		{selector: '#historique', offset: 300, callback: function(el){Materialize.showStaggeredList('#historique');}}
		];
		Materialize.scrollFire(options);


		/*Scroll smooth*/
		$('a[href^="#"]').on('click', function(evt){
               // bloquer le comportement par défaut: on ne rechargera pas la page
               evt.preventDefault();
               // enregistre la valeur de l'attribut  href dans la variable target
        		var target = $(this).attr('href');
               /* le sélecteur $(html, body) permet de corriger un bug sur chrome
               et safari (webkit) */
        		$('html, body')
               // on arrête toutes les animations en cours
               .stop()
               /* on fait maintenant l'animation vers le haut (scrollTop) vers
                notre ancre target */
               .animate({scrollTop: $(target).offset().top}, 1000 );
        });

        $('.switch_masque input[type=checkbox]').on('click', function(evt){
            if($(this).prop('checked') == true){
               $('#choix_masque').css('display', 'block');
           }
           else {
               if ($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_cadre').length > 0) {
                 $('#user_personne_commandes_attributes_0_products_attributes_42_couleur_cadre').val(""); 
                 $('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val(""); 
                 $('#res_user_personne_commandes_attributes_0_products_attributes_42_couleur_cadre').text("")
                 $('#res_user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').text("")
                 $('#user_personne_commandes_attributes_0_products_attributes_42_couleur_cadre').material_select();
                 $('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').material_select();
               } else {
                 $('#personne_commandes_attributes_0_products_attributes_42_couleur_cadre').val(""); 
                 $('#personne_commandes_attributes_0_products_attributes_42_couleur_verre').val(""); 
                 $('#res_personne_commandes_attributes_0_products_attributes_42_couleur_cadre').text("")
                 $('#res_personne_commandes_attributes_0_products_attributes_42_couleur_verre').text("")
                 $('#personne_commandes_attributes_0_products_attributes_42_couleur_cadre').material_select();
                 $('#personne_commandes_attributes_0_products_attributes_42_couleur_verre').material_select();
                 
               }

               $('#choix_masque').css('display', 'none');
           }
       });

       var user_personne = ["user_personne","personne"]
       function ryft_color() {
          if ($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_cadre').length > 0) {
             if($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_cadre').val() == "Bleu") {
                 if($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Bleu"){
                   $('.img_ryft').attr('src', '/assets/masque/ryft_11.jpg');
                 }
                 else if ($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Noir") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_12.jpg');
                 }
                 else if ($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Rouge") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_13.jpg');
                 }
             } else if($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_cadre').val() == "Rouge"){
                 if($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Bleu"){
                   $('.img_ryft').attr('src', '/assets/masque/ryft_21.jpg');
                 }
                 else if ($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Noir") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_22.jpg');
                 }
                 else if ($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Rouge") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_23.jpg');
                 }
             } else if($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_cadre').val() == "Rose"){
                 if($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Bleu"){
                   $('.img_ryft').attr('src', '/assets/masque/ryft_31.jpg');
                 }
                 else if ($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Noir") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_32.jpg');
                 }
                 else if ($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Rouge") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_33.jpg');
                 }
             } else if($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_cadre').val() == "Blanc"){
                 if($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Bleu"){
                   $('.img_ryft').attr('src', '/assets/masque/ryft_41.jpg');
                 }
                 else if ($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Noir") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_42.jpg');
                 }
                 else if ($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Rouge") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_43.jpg');
                 }
             } else if($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_cadre').val() == "Jaune"){
                 if($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Bleu"){
                   $('.img_ryft').attr('src', '/assets/masque/ryft_51.jpg');
                 }
                 else if ($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Noir") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_52.jpg');
                 }
                 else if ($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Rouge") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_53.jpg');
                 }
             } else{
               $('.img_ryft').attr('src', '/assets/masque/ryft_11.jpg');
             }
          } else if ($('#personne_commandes_attributes_0_products_attributes_42_couleur_cadre').length > 0) {
             if($('#personne_commandes_attributes_0_products_attributes_42_couleur_cadre').val() == "Bleu") {
                 if($('#personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Bleu"){
                   $('.img_ryft').attr('src', '/assets/masque/ryft_11.jpg');
                 }
                 else if ($('#personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Noir") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_12.jpg');
                 }
                 else if ($('#personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Rouge") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_13.jpg');
                 }
             } else if($('#personne_commandes_attributes_0_products_attributes_42_couleur_cadre').val() == "Rouge"){
                 if($('#personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Bleu"){
                   $('.img_ryft').attr('src', '/assets/masque/ryft_21.jpg');
                 }
                 else if ($('#personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Noir") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_22.jpg');
                 }
                 else if ($('#personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Rouge") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_23.jpg');
                 }
             } else if($('#personne_commandes_attributes_0_products_attributes_42_couleur_cadre').val() == "Rose"){
                 if($('#personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Bleu"){
                   $('.img_ryft').attr('src', '/assets/masque/ryft_31.jpg');
                 }
                 else if ($('#personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Noir") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_32.jpg');
                 }
                 else if ($('#personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Rouge") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_33.jpg');
                 }
             } else if($('#personne_commandes_attributes_0_products_attributes_42_couleur_cadre').val() == "Blanc"){
                 if($('#personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Bleu"){
                   $('.img_ryft').attr('src', '/assets/masque/ryft_41.jpg');
                 }
                 else if ($('#personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Noir") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_42.jpg');
                 }
                 else if ($('#personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Rouge") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_43.jpg');
                 }
             } else if($('#personne_commandes_attributes_0_products_attributes_42_couleur_cadre').val() == "Jaune"){
                 if($('#personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Bleu"){
                   $('.img_ryft').attr('src', '/assets/masque/ryft_51.jpg');
                 }
                 else if ($('#personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Noir") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_52.jpg');
                 }
                 else if ($('#personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Rouge") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_53.jpg');
                 }
             } else{
               $('.img_ryft').attr('src', '/assets/masque/ryft_11.jpg');
             }

          }
 
         
       }
         
         if ($('#personne_commandes_attributes_0_products_attributes_42_couleur_verre').length > 0) {
           $('#personne_commandes_attributes_0_products_attributes_42_couleur_verre').change(function(){
             ryft_color()
           });
           $('#personne_commandes_attributes_0_products_attributes_42_couleur_cadre').change(function(){
             ryft_color()
           });
         }
         if ($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').length > 0) {
           $('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').change(function(){
             ryft_color()
           });
           $('#user_personne_commandes_attributes_0_products_attributes_42_couleur_cadre').change(function(){
             ryft_color()
           });
         }

       // Récapitulatif
       // Total
       function recap_total() {
         var td_prices = $("td[id^=price]")
         var nombre = td_prices.length
         var price = 0
         for (i = 0; i < nombre; i++) {
           price += parseFloat(td_prices[i].textContent)
         }
         $('#price_total').text(Math.round(price*100)/100+"€")
       }

       // Pack
       if ($('#user_personne_commandes_attributes_0_products_attributes_0_id').length > 0) {
           id = $('#user_personne_commandes_attributes_0_products_attributes_0_id').attr('id');
  
           $('#res_' + id).text($('#' + id + ' option[value='+ $('#user_personne_commandes_attributes_0_products_attributes_0_id').val() + ']').attr("data-name"));
           $('#price_' + id).text($('#' + id + ' option[value='+ $('#user_personne_commandes_attributes_0_products_attributes_0_id').val() + ']').attr("data-price"));
           recap_total()
       }
       if ($('#personne_commandes_attributes_0_products_attributes_0_id').length > 0) {
           id = $('#personne_commandes_attributes_0_products_attributes_0_id').attr('id');
  
           $('#res_' + id).text($('#' + id + ' option[value='+ $('#personne_commandes_attributes_0_products_attributes_0_id').val() + ']').attr("data-name"));
           $('#price_' + id).text($('#' + id + ' option[value='+ $('#personne_commandes_attributes_0_products_attributes_0_id').val() + ']').attr("data-price"));
           recap_total()
       }
       

       $('select').change(function(){
           id = $(this).attr('id');

           if ($(this).val() == "") {
             $('#res_' + id).text("");
             $('#price_' + id).text("0€");
             recap_total()
           } else {
             $('#res_' + id).text($('#' + id + ' option[value='+ $(this).val() + ']').attr("data-name"));
             $('#price_' + id).text($('#' + id + ' option[value='+ $(this).val() + ']').attr("data-price"));
             recap_total()
           }
        
       // Transports
           user_personne.forEach(function(u) {
             var transports = [u+"_commandes_attributes_0_products_attributes_2_id",
                               u+"_commandes_attributes_0_products_attributes_3_id"]
             // On prend l'aller-retour
             if (id == u+"_commandes_attributes_0_products_attributes_1_id") {
               
               if ($('#'+id).val() != "") {
                 transports.forEach(function(e) {
                   $('#res_' + e).text("");
                   $('#price_' + e).text("0€");
                 })
               } else {
                 transports.forEach(function(e) {
                   if ($('#'+e).val() != "") {
                     $('#res_' + e).text($('#' + e + ' option[value='+ $('#'+e).val() + ']').attr("data-name"));
                     $('#price_' + e).text($('#' + e + ' option[value='+ $('#'+e).val() + ']').attr("data-price")); 
                   }
                 })
               }
             }

             // On prend aller et/ou retour
             transports.forEach(function(e) {
               if (id == e) {
                 if ($(u+"_commandes_attributes_0_products_attributes_1_id").val() != "") {
                   $('#res_' + e).text("");
                   $('#price_' + e).text("0€");
                 }
               }
             })
             recap_total()
           })
       });
        

       $('input[type=text]').change(function(){
           id = $(this).attr('id');

           $('#res_' + id).text($(this).val());
       });

       $('input[type=checkbox]').change(function(){
           var id = $(this).attr('id');
           if($(this).is(':checked')){
               $('#res_' + id).text('Oui');
               $('#price_' + id).text($(this).attr("data-price"));
               recap_total()
           }
           else{
                $('#res_' + id).text('Non');
                $('#price_' + id).text("0€");
                recap_total()
           }

       // Assurances
 
           // Si assurance tout compris coché
           user_personne.forEach(function(u) {
             var assurances = [u+"_commandes_attributes_0_products_attributes_43_product_id_50",
                               u+"_commandes_attributes_0_products_attributes_44_product_id_51",
                               u+ "_commandes_attributes_0_products_attributes_45_product_id_52",
                               u+"_commandes_attributes_0_products_attributes_47_product_id_54"]
             assurances.forEach(function(e) {
               if (id == e) {
                 // Si assurance (on annule tout si la personne coche tout compris ou pas d'assu
                 if (id != u+"_commandes_attributes_0_products_attributes_47_product_id_54") {
                   if ($('#'+u+'_commandes_attributes_0_products_attributes_46_product_id_53').is(':checked') || $('#'+u+'_commandes_attributes_0_products_attributes_47_product_id_54').is(':checked')) {
                       $('#'+e).prop('checked', false);
                       $('#res_' + e).text('Non');
                       $('#price_' + e).text("0€");
                   }
                 } else {
                 // Si pas d'assu (on annule tout si la personne coche tout compris)
                   if ($('#'+u+'_commandes_attributes_0_products_attributes_46_product_id_53').is(':checked')) {
                       $('#'+e).prop('checked', false);
                       $('#res_' + e).text('Non');
                       $('#price_' + e).text("0€");
                   }
  
                 }
               }
             })

             // On coche assurance tout compris, annuler le reste, sinon remettre
             if (id == u+"_commandes_attributes_0_products_attributes_46_product_id_53") {
               if ($('#'+u+'_commandes_attributes_0_products_attributes_46_product_id_53').is(':checked'))  {
                 var assurances = [u+"_commandes_attributes_0_products_attributes_43_product_id_50",
                                   u+"_commandes_attributes_0_products_attributes_44_product_id_51",
                                   u+"_commandes_attributes_0_products_attributes_45_product_id_52",
                                   u+"_commandes_attributes_0_products_attributes_47_product_id_54"]
                 assurances.forEach(function(e) {
                   $('#res_' + e).text('Non');
                   $('#price_' + e).text("0€");
                 })
               } else {
                 var assurances = [u+"_commandes_attributes_0_products_attributes_43_product_id_50",
                                   u+"_commandes_attributes_0_products_attributes_44_product_id_51",
                                   u+"_commandes_attributes_0_products_attributes_45_product_id_52",
                                   u+"_commandes_attributes_0_products_attributes_47_product_id_54"]
                 assurances.forEach(function(e) {
                   $('#res_' + e).text($('#'+e).attr("data-name"));
                   $('#price_' + e).text($('#'+e).attr("data-price"));
                 })
               }
             }
  
             // On coche pas d'assurance tout compris, annuler le reste sauf assu tout compris
             if (id == u+"_commandes_attributes_0_products_attributes_47_product_id_54") {
               if ($('#'+u+'_commandes_attributes_0_products_attributes_47_product_id_54').is(':checked'))  {
                 var assurances = [u+"_commandes_attributes_0_products_attributes_43_product_id_50",
                                   u+"_commandes_attributes_0_products_attributes_44_product_id_51",
                                   u+"_commandes_attributes_0_products_attributes_45_product_id_52"]
                 assurances.forEach(function(e) {
                   $('#res_' + e).text('Non');
                   $('#price_' + e).text("0€");
                 })
               } else {
                 var assurances = [u+"_commandes_attributes_0_products_attributes_43_product_id_50",
                                   u+"_commandes_attributes_0_products_attributes_44_product_id_51",
                                   u+"_commandes_attributes_0_products_attributes_45_product_id_52"]
                 assurances.forEach(function(e) {
                   $('#res_' + e).text($('#'+e).attr("data-name"));
                   $('#price_' + e).text($('#'+e).attr("data-price"));
                 })
               }
             }
           })
       });

       $('input[type=radio]').change(function(){
           id = $(this).attr('id');
           if($(this).is(':checked')){
               $('#res_' + id).text('Oui');
               recap_total()
           }
           else{
                $('#res_' + id).text('Non');
                recap_total()
           }
           
           user_personne.forEach(function(u) {
             if (id == u+"_commandes_attributes_0_products_attributes_4_id_4") {
               $('#res_'+u+'_commandes_attributes_0_products_attributes_4_id_5').text('Non');
             }
           })

       });

    });
});
