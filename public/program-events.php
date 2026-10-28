<?php
require_once __DIR__ . '/../app/Repositories/PublicProgramsRepository.php';

use Core\Database;
use Repo\PublicProgramsRepository;

$programId     = filter_var($_GET['program'] ?? '', FILTER_VALIDATE_INT, ['options' => ['min_range' => 1]]);
$programRecord = null;
$events        = [];

if ($programId) {
	try {
		$programRepo   = new PublicProgramsRepository(Database::connect());
		$programRecord = $programRepo->findProgram($programId);

		if ($programRecord) {
			foreach ($programRepo->programsNews($programId) as $row) {
				$img = trim((string) ($row['featured_image'] ?? ''));
				if ($img !== '' && !preg_match('#^(https?:)?//#i', $img) && $img[0] !== '/' && strpos($img, 'admin/') !== 0) {
					$img = 'admin/assets/images/' . ltrim($img, '/'); // adjust to where featured_image files live
				}
				$desc = trim((string) ($row['excerpt'] ?? ''));
				if ($desc === '') {
					$desc = trim(strip_tags((string) ($row['content'] ?? '')));
				}
				$events[] = [
					'title'       => (string) $row['title'],
					'date'        => 'Published ' . date('F j, Y', strtotime((string) $row['published_at'])),
					'image'       => $img !== '' ? $img : 'images/UCC2.png',
					'description' => $desc,
				];
			}
		}
	} catch (Throwable $e) {
		error_log('Program events error: ' . $e->getMessage());
		$programRecord = null;
		$events        = [];
	}
}



if (!$programRecord) {
	http_response_code(404);
}

$pageHeading = $programRecord ? strtoupper($programRecord['name']) . ' EVENTS' : 'PROGRAM EVENTS';

// Build these BEFORE the includes so navbar/utility-bar can't overwrite them
$programEventsJson = json_encode(
	$events,
	JSON_HEX_TAG | JSON_HEX_AMP | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_UNESCAPED_UNICODE | JSON_INVALID_UTF8_SUBSTITUTE
) ?: '[]';
$programEventsId = (int) $programId;
unset($events, $row, $img, $desc);
?>


<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="Discover program-specific events, academic gatherings, campus activities, and celebrations at the University of Caloocan City.">
	<title>UCC | <?= htmlspecialchars($pageHeading, ENT_QUOTES, 'UTF-8') ?></title>
	<link rel="icon" type="image/png" href="images/UCC2.png">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&family=Oswald:wght@500;600;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="utility.css">
	<link rel="stylesheet" href="program-events.css">
	<link rel="stylesheet" href="assets/utility-bar.css">
	<link rel="stylesheet" href="assets/navbar.css">
	<link rel="stylesheet" href="assets/footer.css">
</head>


<body>
	<?php include __DIR__ . '/includes/utility-bar.php'; ?>
	<?php include __DIR__ . '/includes/navbar.php'; ?>


	<div class="page-dots" aria-hidden="true">
		<span class="dot-pattern dot-1"></span>
		<span class="dot-pattern dot-2"></span>
		<span class="dot-pattern dot-3"></span>
		<span class="dot-pattern dot-4"></span>
	</div>


	<main class="news-page" id="programEventsPage" data-program-id="<?= $programEventsId ?>">

		<script id="programEventsData" type="application/json"><?= $programEventsJson ?></script>
		<div class="news-decor news-decor-top" aria-hidden="true"></div>
		<div class="news-decor news-decor-right" aria-hidden="true"></div>
		<div class="news-decor news-decor-bottom" aria-hidden="true"></div>
		<section class="news-container">

			<div class="news-heading">
				<div>
					<h1 id="programEventsTitle"><?= htmlspecialchars($pageHeading, ENT_QUOTES, 'UTF-8') ?></h1>
					<div class="news-heading-line">
						<span></span>
						<i></i>
						<span></span>
					</div>
					<p id="programEventsDescription">Discover the events, celebrations, academic gatherings, and activities organized by this program at the University of Caloocan City.</p>
				</div>
			</div>


			<section class="news-featured" id="featuredEvent"></section>


			<div class="news-section-title">
				<div>
					<span>MORE PROGRAM EVENTS</span>
					<div class="news-mini-line">
						<i></i>
						<i></i>
						<i></i>
					</div>
				</div>
			</div>


			<section class="news-grid-wrapper">
				<button type="button" class="news-slider-arrow news-slider-prev" id="eventPrev" aria-label="Previous events">‹</button>
				<div class="news-grid" id="eventGrid"></div>
				<button type="button" class="news-slider-arrow news-slider-next" id="eventNext" aria-label="Next events">›</button>
			</section>


			<div class="news-pagination" id="eventPagination"></div>


			<button type="button" class="news-view-all" id="viewAllEvents">
				<span>▤</span>
				VIEW ALL EVENTS
			</button>

			<p id="noProgramEvents" hidden>No events are currently available for this program.</p>
		</section>
	</main>


	<div class="news-modal" id="eventModal" aria-hidden="true">
		<div class="news-modal-backdrop" data-event-modal-close></div>

		<div class="news-modal-dialog" role="dialog" aria-modal="true" aria-labelledby="eventModalTitle">

			<div class="news-modal-header">
				<div class="news-modal-heading">
					<span class="news-modal-label">PROGRAM EVENTS</span>
					<h2 id="eventModalTitle">Event Title</h2>
				</div>

				<button type="button" class="news-modal-close" data-event-modal-close aria-label="Close event details">×</button>
			</div>


			<div class="news-modal-body">
				<figure class="news-modal-image">
					<a href="#" id="eventModalImageLink" aria-label="View full-size event image">
						<img id="eventModalImage" src="" alt="">
					</a>
				</figure>


				<div class="news-modal-meta">
					<span class="news-modal-date" id="eventModalDate">Event date</span>
				</div>


				<div class="news-modal-accent"></div>
				<p class="event-modal-description" id="eventModalDescription">Event details will be added here.</p>
			</div>


			<div class="news-modal-footer">
				University of Caloocan City • Program Events
			</div>
		</div>
	</div>


	<div class="news-image-lightbox" id="eventImageLightbox" aria-hidden="true">

		<div class="news-image-lightbox-backdrop" data-event-image-close></div>

		<div class="news-image-lightbox-content">
			<button type="button" class="news-image-lightbox-close" data-event-image-close aria-label="Close full-size image">×</button>
			<img id="eventLightboxImage" src="" alt="">
		</div>

	</div>


	<?php include __DIR__ . '/includes/footer.php'; ?>


	<button class="back-top" id="backTop" aria-label="Back to top">↑</button>
	<script src="script.js"></script>
	<script src="program-events.js"></script>
</body>
</html>