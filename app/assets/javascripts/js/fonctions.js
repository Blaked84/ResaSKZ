

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


    });
	 });
