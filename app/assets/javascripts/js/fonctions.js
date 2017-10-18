

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
               $('#choix_masque').css('display', 'none');
           }
       });

       function ryft_color() {
           if($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_cadre').val() == "Bleu"){
               if($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Bleu"){
                  $('.img_ryft').attr('src', '/assets/masque/ryft_11.jpg');
               }
               else if ($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Noir") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_12.jpg');
               }
               else if ($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Rouge") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_13.jpg');
               }
           }
           else if($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_cadre').val() == "Rouge"){
               if($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Bleu"){
                  $('.img_ryft').attr('src', '/assets/masque/ryft_21.jpg');
               }
               else if ($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Noir") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_22.jpg');
               }
               else if ($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Rouge") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_23.jpg');
               }
           }
           else if($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_cadre').val() == "Rose"){
               if($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Bleu"){
                  $('.img_ryft').attr('src', '/assets/masque/ryft_31.jpg');
               }
               else if ($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Noir") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_32.jpg');
               }
               else if ($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Rouge") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_33.jpg');
               }
           }
           else if($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_cadre').val() == "Blanc"){
               if($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Bleu"){
                  $('.img_ryft').attr('src', '/assets/masque/ryft_41.jpg');
               }
               else if ($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Noir") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_42.jpg');
               }
               else if ($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Rouge") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_43.jpg');
               }
           }
           else if($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_cadre').val() == "Jaune"){
               if($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Bleu"){
                  $('.img_ryft').attr('src', '/assets/masque/ryft_51.jpg');
               }
               else if ($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Noir") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_52.jpg');
               }
               else if ($('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').val() == "Rouge") {
                   $('.img_ryft').attr('src', '/assets/masque/ryft_53.jpg');
               }
           }
           else{
               $('.img_ryft').attr('src', '/assets/masque/ryft_11.jpg');
           }


       }

       $('#user_personne_commandes_attributes_0_products_attributes_42_couleur_verre').change(function(){
         ryft_color()
       });
       $('#user_personne_commandes_attributes_0_products_attributes_42_couleur_cadre').change(function(){
         ryft_color()
       });

       $('select').change(function(){
           id = $(this).attr('id');

           $('#res_' + id).text($('#' + id + ' option[value='+ $(this).val() + ']').text());
       });

       $('input[type=text]').change(function(){
           id = $(this).attr('id');

           $('#res_' + id).text($(this).val());
       });

       $('input[type=checkbox]').change(function(){
           id = $(this).attr('id');
           if($(this).is(':checked')){
               $('#res_' + id).text('Oui');
           }
           else{
                $('#res_' + id).text('Non');
           }

       });
    });
	 });
