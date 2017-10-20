/** 
  Rowsky 144Me215 (Wassim Belmezouar) - 20/10
*/

$(function() {
  if ($("[id^=edit_user]").length > 0) {
    function validate_transports_user_pers() {
      transportsar= document.getElementById("user_personne_commandes_attributes_0_products_attributes_1_id");
      transportsa= document.getElementById("user_personne_commandes_attributes_0_products_attributes_2_id");
      transportsr= document.getElementById("user_personne_commandes_attributes_0_products_attributes_3_id"); 
      return (transportsar.value != "") || (transportsa.value!="" && transportsr.value !="")
    }


    function validate_skis_user_pers() {
      skis= document.getElementById("user_personne_commandes_attributes_0_products_attributes_10_id");
      return skis.value != ""
    }

    function validate_resid_user_pers() {
      res = document.getElementById("user_personne_typeresid_id")
      return res.value != ""
    }

    function validate_assurances() {
      a = document.getElementById("user_personne_commandes_attributes_0_products_attributes_43_product_id_50");
      r = document.getElementById("user_personne_commandes_attributes_0_products_attributes_44_product_id_51");
      s = document.getElementById("user_personne_commandes_attributes_0_products_attributes_45_product_id_52");
      t = document.getElementById("user_personne_commandes_attributes_0_products_attributes_46_product_id_53");
      n = document.getElementById("user_personne_commandes_attributes_0_products_attributes_47_product_id_54");
      return (a.checked == true) || (r.checked == true) || (s.checked == true) || (t.checked == true) || (n.checked == true)
    }

    $('button[type=submit]').click(function(e){
      e.preventDefault();
      var go = true
      var validators = [validate_transports_user_pers(),validate_skis_user_pers(),validate_assurances(),validate_resid_user_pers()]
      var toasts = document.querySelectorAll(".toast-message"); 

      // Validating transports
      if (validate_transports_user_pers() == false) {
        message = "Précise bien ton choix pour le transport (A/R ou (A et/ou R))"
        published = false
        toasts.forEach(function(t) {
          if (t.textContent == message) {
            published = true
          }
        })
        if (published == false) {
          toastr.error("<a href='#le_transport'>"+message+"</a>")
        }

      }

      // Validating skis
      if (validate_skis_user_pers() == false) {
        message = "Pas si vite! Tu n'as pas encore choisi tes paires de ski!"
        published = false
        toasts.forEach(function(t) {
          if (t.textContent == message) {
            published = true
          }
        })
        if (published == false) {
          toastr.error("<a href='#les_skis'>"+message+"</a>");
        }
      }

      // Validating assurances
      if (validate_assurances() == false) {
        message = "Tu dois choisir une assurance! Si t'en veux pas, coche: Pas d'assurance"
        published = false
        toasts.forEach(function(t) {
          if (t.textContent == message) {
            published = true
          }
        })
        if (published == false) {
          toastr.error("<a href='#assurances'>"+message+"</a>");
        }
      }

      // Validating Resid's
      if (validate_resid_user_pers() == false) {
        message = "Tu dois choisir ta résid's"
        published = false
        toasts.forEach(function(t) {
          if (t.textContent == message) {
            published = true
          }
        })
        if (published == false) {
          toastr.error("<a href='#la_residence'>"+message+"</a>");
        }
      }
    
      validators.forEach(function(e) {
         if (e == false) {
           go = false
         }
      })
      if (go == true) {
        $('[id^=edit_user]').submit();
      }
    })



  } else {
    function validate_transports_pers() {
      transportsar= document.getElementById("personne_commandes_attributes_0_products_attributes_1_id");
      transportsa= document.getElementById("personne_commandes_attributes_0_products_attributes_2_id");
      transportsr= document.getElementById("personne_commandes_attributes_0_products_attributes_3_id");
      return (transportsar.value != "") || (transportsa.value!="" && transportsr.value !="")
    }
  
    function validate_skis_pers() {
      skis= document.getElementById("personne_commandes_attributes_0_products_attributes_10_id");
      return skis.value != ""
    }

    function validate_resid_pers() {
      res = document.getElementById("personne_typeresid_id")
      return res.value != ""
    }

    function validate_assurances() {
      a = document.getElementById("user_personne_commandes_attributes_0_products_attributes_43_product_id_50");
      r = document.getElementById("user_personne_commandes_attributes_0_products_attributes_44_product_id_51");
      s = document.getElementById("user_personne_commandes_attributes_0_products_attributes_45_product_id_52");
      t = document.getElementById("user_personne_commandes_attributes_0_products_attributes_46_product_id_53");
      n = document.getElementById("user_personne_commandes_attributes_0_products_attributes_47_product_id_54");
      return (a.checked == true) || (r.checked == true) || (s.checked == true) || (t.checked == true) || (n.checked == true)
    }

    $('button[type=submit]').click(function(e){
      e.preventDefault();
      var go = true
      var validators = [validate_transports_pers(),validate_skis_pers(),validate_assurances(),validate_resid_pers()]
      var toasts = document.querySelectorAll(".toast-message"); 

      // Validating transports
      if (validate_transports_pers() == false) {
        message = "Précise bien ton choix pour le transport (A/R ou (A et/ou R))"
        published = false
        toasts.forEach(function(t) {
          if (t.textContent == message) {
            published = true
          }
        })
        if (published == false) {
          toastr.error("<a href='#le_transport'>"+message+"</a>")
        }
      }

      // Validating skis
      if (validate_skis_pers() == false) {
        message = "Pas si vite! Tu n'as pas encore choisi tes paires de ski!"
        published = false
        toasts.forEach(function(t) {
          if (t.textContent == message) {
            published = true
          }
        })
        if (published == false) {
          toastr.error("<a href='#les_skis'>"+message+"</a>");
        }
      }

      // Validating assurances
      if (validate_assurances() == false) {
        message = "Tu dois choisir une assurance! Si t'en veux pas, coche: Pas d'assurance"
        published = false
        toasts.forEach(function(t) {
          if (t.textContent == message) {
            published = true
          }
        })
        if (published == false) {
          toastr.error("<a href='#assurances'>"+message+"</a>");
        }
      }

      // Validating Resid's
      if (validate_resid_pers() == false) {
        message = "Tu dois choisir ta résid's"
        published = false
        toasts.forEach(function(t) {
          if (t.textContent == message) {
            published = true
          }
        })
        if (published == false) {
          toastr.error("<a href='#la_residence'>"+message+"</a>");
        }
      }
      validators.forEach(function(e) {
         if (e == false) {
           go = false
         }
      })
      if (go == true) {
        $("#new_personne").submit();
      }
    })

  }

})
