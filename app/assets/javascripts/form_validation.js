// Add custom validation rule.p
$.formUtils.addValidator({
    name : 'email',
    validatorFunction : function(value, $el, config, language, $form) {
        return value!="";
    },
    errorMessage : 'Vous devez saisir une adresse email valide',
});

$.formUtils.addValidator({
    name : 'nom',
    validatorFunction : function(value, $el, config, language, $form) {
        return value!="";
    },
    errorMessage : 'Vous devez saisir un nom',
});

$.formUtils.addValidator({
    name : 'prenom',
    validatorFunction : function(value, $el, config, language, $form) {
        return value!="";
    },
    errorMessage : 'Vous devez saisir un prenom',
});

$.formUtils.addValidator({
    name : 'genre_id',
    validatorFunction : function(value, $el, config, language, $form) {
        return value!="";
    },
    errorMessage : 'Vous devez selectioner un genre',
});

$.formUtils.addValidator({
    name : 'promo',
    validatorFunction : function(value, $el, config, language, $form) {
        return value!="";
    },
    errorMessage : 'Vous devez selectioner une promo (ou hyp promo)',
});
