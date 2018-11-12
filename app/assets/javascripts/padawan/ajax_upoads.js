$(document).ready(function() {
    var uploadObj = $("#exercise_user_file").uploadFile({
        url: "/padawan/viveres/send_exercises/" + $('.exercise-preview').data('exercise-id'),
        multiple: false,
        fileName: "exercise_user[file]",
        autoSubmit: false,
        formData: { },
        onSuccess:function(files,data,xhr)
        {
            window.location.href = data.to;
            console.log('Success');
        }
    });

    $("#fileUpload").click(function(e) {
        e.preventDefault();
        $.rails.disableFormElements($($.rails.formSubmitSelector));
        uploadObj.startUpload();
    });
});