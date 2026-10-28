document.addEventListener("DOMContentLoaded", function () {
	const newsModal = document.getElementById("newsModal");
	const calendarModal = document.getElementById("calendarModal");
	const newsModalTitle = document.getElementById("newsModalTitle");
	const newsModalCategory = document.getElementById("newsModalCategory");
	const newsModalDate = document.getElementById("newsModalDate");
	const newsModalImage = document.getElementById("newsModalImage");
	const newsModalDescription = document.getElementById("newsModalDescription");
	const newsModalClose = document.getElementById("newsModalClose");
	const newsModalBackdrop = document.getElementById("newsModalBackdrop");
	const calendarModalClose = document.getElementById("calendarModalClose");
	const calendarModalBackdrop = document.getElementById("calendarModalBackdrop");

	
	const articles = window.newsArticles || {};

	function openModal(modal) {
		if (!modal) return;
		modal.classList.add("is-open", "active", "show");
		modal.setAttribute("aria-hidden", "false");
		document.body.classList.add("modal-open");
	}

	function closeModal(modal) {
		if (!modal) return;
		modal.classList.remove("is-open", "active", "show");
		modal.setAttribute("aria-hidden", "true");
		if (!document.querySelector(".news-modal.is-open, .calendar-modal.is-open")) {
			document.body.classList.remove("modal-open");
		}
	}

	function openNewsArticle(id) {
		const article = articles[id];
		if (!article || !newsModal) return;

		newsModalCategory.textContent = "UNIVERSITY NEWS";
		newsModalTitle.textContent = article.title;
		newsModalDate.textContent = article.date || "University of Caloocan City";
		newsModalDescription.innerHTML = article.content || "<p>No article content available.</p>";

		if (newsModalImage) {
			if (article.image) {
				newsModalImage.src = article.image;
				newsModalImage.alt = article.title;
				newsModalImage.parentElement.style.display = "block";
			} else {
				newsModalImage.removeAttribute("src");
				newsModalImage.alt = "";
				newsModalImage.parentElement.style.display = "none";
			}
		}

		const body = newsModal.querySelector(".news-modal-body");
		if (body) body.scrollTop = 0;

		openModal(newsModal);
	}

	// Read More link
	document.querySelectorAll(".news-card .read-more").forEach(function (link) {
		link.addEventListener("click", function (event) {
			event.preventDefault();
			event.stopPropagation();
			openNewsArticle(this.getAttribute("data-news-id"));
		});
	});

	// Clicking anywhere else on the card also opens it
	document.querySelectorAll(".news-card[data-news]").forEach(function (card) {
		card.addEventListener("click", function (event) {
			if (event.target.closest("a")) return;
			openNewsArticle(this.getAttribute("data-news"));
		});
	});

	const calendarButton = document.getElementById("viewFullCalendar");
	if (calendarButton) {
		calendarButton.addEventListener("click", function (event) {
			event.preventDefault();
			openModal(calendarModal);
		});
	}

	if (newsModalClose) {
		newsModalClose.addEventListener("click", function () {
			closeModal(newsModal);
		});
	}
	if (newsModalBackdrop) {
		newsModalBackdrop.addEventListener("click", function () {
			closeModal(newsModal);
		});
	}
	if (calendarModalClose) {
		calendarModalClose.addEventListener("click", function () {
			closeModal(calendarModal);
		});
	}
	if (calendarModalBackdrop) {
		calendarModalBackdrop.addEventListener("click", function () {
			closeModal(calendarModal);
		});
	}

	document.addEventListener("keydown", function (event) {
		if (event.key === "Escape") {
			closeModal(newsModal);
			closeModal(calendarModal);
		}
	});
});