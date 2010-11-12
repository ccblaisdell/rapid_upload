$(function(){
	var uploader = new qq.FileUploader({
	    // pass the dom node (ex. $(selector)[0] for jQuery users)
	    element: document.getElementById('image_uploader'),
	    // path to server-side upload script
	    action: '/images.json',
			multiple: false,
			debug: true,
			onComplete: function(id, fileName, responseJSON) {
				console.log(id, fileName, responseJSON);
				$("#images").append(responseJSON);
			}
	});
});