<?php
use Core\Database;
use Repo\PublicUniversityNewsRepository;
use Repo\PublicEServicesRepository;
use Repo\PublicRegentsRepository;
use Repo\PublicCalendarRepository;
use Repo\PublicProgramsRepository;

require_once __DIR__ . '/../app/Repositories/PublicCampusRepository.php';
require_once __DIR__ . '/../app/Repositories/PublicProgramsRepository.php';

$campusRepository    = new PublicUniversityNewsRepository(Database::connect());
$eservicesRepository = new PublicEServicesRepository(Database::connect());
$regentsRepository   = new PublicRegentsRepository(Database::connect());
$calendarRepository  = new PublicCalendarRepository(Database::connect());

$universityNews = $campusRepository->getThreeLatestNews();
$quickLinks     = $eservicesRepository->getQuickLinks();
$chairman       = $regentsRepository->getChairmanImage();
$calendarEvents = $calendarRepository->getOverview();

// Programs for the Program Events cards
try {
	$homePrograms = (new PublicProgramsRepository(Database::connect()))->getPrograms();
} catch (Throwable $e) {
	error_log('Homepage programs error: ' . $e->getMessage());
	$homePrograms = [];
}

// Carousel arrows/dots are only needed when there are more than 4 programs
$showProgramControls = count($homePrograms) > 4;

// Sidebar shows the first 2 events, the modal shows all of them
$sidebarEvents  = array_slice($calendarEvents, 0, 2);

if (!function_exists('escStudent')) {
	function escStudent(?string $value): string
	{
		return htmlspecialchars((string)$value, ENT_QUOTES, 'UTF-8');
	}
}

if (!function_exists('timeAgo')) {
	function timeAgo(?string $datetime): string
	{
		if (empty($datetime)) {
			return 'recently';
		}

		try {
			$then = new DateTimeImmutable($datetime);
		} catch (Exception $e) {
			return 'recently';
		}

		$now = new DateTimeImmutable('now');

		if ($then > $now) {
			return 'just now';
		}

		$diff = $then->diff($now);

		if ($diff->y > 0) {
			return $diff->y === 1 ? 'a year ago' : $diff->y . ' years ago';
		}
		if ($diff->m > 0) {
			return $diff->m === 1 ? 'a month ago' : $diff->m . ' months ago';
		}
		if ($diff->d > 0) {
			return $diff->d === 1 ? 'a day ago' : $diff->d . ' days ago';
		}
		if ($diff->h > 0) {
			return $diff->h === 1 ? 'an hour ago' : $diff->h . ' hours ago';
		}
		if ($diff->i > 0) {
			return $diff->i === 1 ? 'a minute ago' : $diff->i . ' minutes ago';
		}

		return 'just now';
	}
}

if (!function_exists('calendarDateText')) {
	function calendarDateText(?string $start, ?string $end): string
	{
		if (empty($start)) {
			return '';
		}
		try {
			$s = new DateTimeImmutable($start);
			$e = !empty($end) ? new DateTimeImmutable($end) : null;
		} catch (Exception $ex) {
			return '';
		}

		if (!$e || $s->format('Y-m-d') === $e->format('Y-m-d')) {
			return $s->format('F j, Y');
		}
		if ($s->format('Y') !== $e->format('Y')) {
			return $s->format('F j, Y') . ' – ' . $e->format('F j, Y');
		}
		return $s->format('F j') . ' – ' . $e->format('F j, Y');
	}
}

if (!function_exists('calendarBadge')) {
	function calendarBadge(?string $start, ?string $end): array
	{
		try {
			$s = new DateTimeImmutable((string)$start);
			$e = !empty($end) ? new DateTimeImmutable($end) : null;
		} catch (Exception $ex) {
			return ['month' => '', 'days' => '', 'year' => ''];
		}

		$month = strtoupper($s->format('M'));
		$days  = $s->format('j');

		if ($e && $s->format('Y-m-d') !== $e->format('Y-m-d')) {
			if ($s->format('Y-m') === $e->format('Y-m')) {
				$days .= '–' . $e->format('j');
			} else {
				$month .= '–' . strtoupper($e->format('M'));
				$days  .= '–' . $e->format('j');
			}
		}

		return ['month' => $month, 'days' => $days, 'year' => $s->format('Y')];
	}
}

// Article data used by the "Read More" modal
$newsArticles = [];
foreach ($universityNews as $news) {
	$excerpt = trim((string)($news['excerpt'] ?? ''));
	$content = strip_tags((string)($news['content'] ?? ''), '<p><br><strong><em><ul><ol><li><a><h3><h4>');
	$plain   = trim((string)preg_replace('/\s+/', ' ', strip_tags($content)));

	if ($plain === '' && $excerpt !== '') {
		$content = '<p>' . htmlspecialchars($excerpt, ENT_QUOTES, 'UTF-8') . '</p>';
	}

	$newsArticles['news-' . (int)$news['id']] = [
		'title'   => (string)$news['title'],
		'date'    => 'Published ' . timeAgo($news['published_at'] ?? null),
		'image'   => !empty($news['featured_image']) ? 'admin/assets/images/' . $news['featured_image'] : '',
		'content' => $content,
	];
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>UCC | Homepage</title>
	<link rel="icon" type="image/png" href="images/UCC2.png">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&family=Oswald:wght@500;600;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="homepage.css">
	<link rel="stylesheet" href="assets/utility-bar.css">
	<link rel="stylesheet" href="assets/navbar.css">
	<link rel="stylesheet" href="assets/footer.css">
</head>

<body>
	<div class="page-dots" aria-hidden="true">
		<span class="dot-pattern dot-1"></span>
		<span class="dot-pattern dot-2"></span>
		<span class="dot-pattern dot-3"></span>
		<span class="dot-pattern dot-4"></span>
	</div>


	<?php require_once __DIR__ . '/includes/utility-bar.php'; ?>
	<?php require_once __DIR__ . '/includes/navbar.php'; ?>


	<main>
		<!-- HERO -->
		<section class="hero" id="home">
			<video class="hero-slides" autoplay muted loop playsinline>
				<source src="images/HERO-SLIDES.mp4" type="video/mp4">
			</video>

			<div class="hero-gradient"></div>

			<div class="hero-curve" aria-hidden="true">
				<svg viewBox="0 0 1000 120" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg">
					<!-- YELLOW -->
					<path class="curve-gold" d="M0 70 C150 20, 350 20, 800 70 C650 120, 820 120, 930 75 C965 60, 985 35, 1000 25 L1000 140 L0 140 Z"/>
					<!-- GREEN -->
					<path class="curve-green" d="M0 75 C150 25, 350 25, 700 75 C650 125, 820 125, 930 80 C965 65, 985 40, 1000 15 L1000 140 L0 140 Z"/>
					<!-- WHITE -->
					<path class="curve-white" d="M0 80 C150 30, 350 30, 600 80 C650 130, 820 130, 930 85 C965 70, 985 45, 1000 20 L1000 140 L0 140 Z"/>
				</svg>
			</div>


			<!-- HERO CONTENT -->
			<div class="container hero-content">
				<div class="hero-copy reveal">
					<div class="eyebrow">
						UNIVERSITY OF CALOOCAN CITY
						<i></i>
						<i></i>
						<i></i>
						<span></span>
					</div>

					<h1>
						UNIVERSITY OF<br>
						<span>CALOOCAN CITY</span>
					</h1>

					<p>
						A leading local university committed to<br>
						academic excellence, innovation, and service<br>
						to the community.
					</p>

					<div class="hero-buttons">
						<a class="btn btn-primary" href="about.php">EXPLORE UCC <b>➜</b></a>
						<a class="btn btn-light" href="https://aims.ucc-caloocan.edu.ph/ucc/applicants/" target="_blank" rel="noopener noreferrer">APPLY NOW <b>➜</b></a>
					</div>

					<div class="slider-dots" aria-label="Hero slides">
						<button class="active"></button>
						<button></button>
						<button></button>
					</div>
				</div>
			</div>
		</section>


		<!-- NEWS + CALENDAR -->
		<section class="news-section" id="news">
			<div class="container two-column">
				<div class="calendar-dots" aria-hidden="true"></div>


				<!-- UNIVERSITY NEWS -->
				<div class="news-area">
					<div class="news-heading">
						<h2>UNIVERSITY NEWS</h2>
						<a href="news.php" class="view-news-btn">View All News</a>
					</div>

					<div class="news-grid">
						<?php foreach ($universityNews as $news): ?>
							<?php
								$newsKey   = 'news-' . (int)$news['id'];
								$newsImage = !empty($news['featured_image'])
									? 'admin/assets/images/' . $news['featured_image']
									: '';
							?>

							<article class="news-card reveal" data-news="<?= escStudent($newsKey) ?>">
								<div class="news-image" aria-hidden="true"
									<?php if ($newsImage !== ''): ?>
										style="background-image:url('<?= escStudent($newsImage) ?>');background-size:cover;background-position:center;"
									<?php endif; ?>>
								</div>

								<div class="news-body">
									<h3><?= escStudent($news['title']) ?></h3>
									<small>Published <?= escStudent(timeAgo($news['published_at'] ?? null)) ?></small>
									<a href="#" class="read-more" data-news-id="<?= escStudent($newsKey) ?>">
										Read More <span aria-hidden="true">→</span>
									</a>
								</div>

							</article>
						<?php endforeach; ?>

						<?php if (empty($universityNews)): ?>
							<p>No university news available yet.</p>
						<?php endif; ?>
					</div>
				</div>


				<!-- RIGHT SIDEBAR -->
				<aside class="right-sidebar">
					<!-- ACADEMIC CALENDAR -->
					<div class="calendar-card reveal" id="calendar">
						<div class="side-title">
							<i data-lucide="calendar-days" class="calendar-icon" aria-hidden="true"></i>
							<span>ACADEMIC CALENDAR</span>
						</div>


						<?php foreach ($sidebarEvents as $event): ?>
							<?php $badge = calendarBadge($event['starts_at'] ?? null, $event['ends_at'] ?? null); ?>
							<div class="calendar-event">

								<div class="date-badge">
									<strong><?= escStudent($badge['month']) ?></strong>
									<b><?= escStudent($badge['days']) ?></b>
									<small><?= escStudent($badge['year']) ?></small>
								</div>

								<div class="event-info">
									<h3><?= escStudent($event['title']) ?></h3>
									<p><?= escStudent(calendarDateText($event['starts_at'] ?? null, $event['ends_at'] ?? null)) ?></p>
								</div>

							</div>
						<?php endforeach; ?>

						<?php if (empty($sidebarEvents)): ?>
							<div class="calendar-event">

								<div class="event-info">
									<p>No upcoming events.</p>
								</div>

							</div>
						<?php endif; ?>


						<!-- FULL CALENDAR BUTTON -->
						<a class="calendar-button" href="#" id="viewFullCalendar">
							<span>VIEW FULL CALENDAR</span>
							<i data-lucide="arrow-right" aria-hidden="true"></i>
						</a>
					</div>

					<!-- CHAIRMAN CARD -->
					<div class="chairman-card reveal">
						<?php if (!empty($chairman['featured_image'])): ?>
							<img src="admin/assets/images/<?= escStudent($chairman['featured_image']) ?>" alt="Chairman of the Board of Regents">
						<?php endif; ?>

						<div class="chairman-content">
							<h3>CHAIRMAN OF THE<br>BOARD OF REGENTS</h3>
						</div>

					</div>
				</aside>
			</div>
		</section>


		<!-- PROGRAM EVENTS + QUICK LINKS -->
		<section class="explore-section" id="program-events">
			<div class="container">

				<!-- EXPLORE HEADING -->
				<div class="explore-heading">
					<span>DISCOVER EVENTS</span>
					<h2>Program Events</h2>
					<p>Discover exciting events, activities, and celebrations organized by each academic program at UCC.</p>
				</div>


				<!-- PROGRAM EVENTS + QUICK LINKS -->
				<div class="explore-bottom">

					<!-- PROGRAM EVENT CARDS -->
					<div class="program-events-wrapper">
						<div class="feature-grid" id="programEvents">

							<?php foreach ($homePrograms as $homeProgram): ?>
								<a href="program-events.php?program=<?= (int) $homeProgram['id'] ?>" class="feature-card">
									<img src="images/7.jpg" alt="<?= escStudent($homeProgram['name']) ?> program events">
									<div class="feature-overlay"></div>

									<div class="feature-content">
										<div class="feature-icon" aria-hidden="true"><img src="images/FACILITIES.png" alt=""></div>
										<h3><?= escStudent($homeProgram['name']) ?></h3>
										<p>Discover academic activities and events for <?= escStudent($homeProgram['name']) ?> program.</p>
									</div>

									<span class="feature-arrow" aria-hidden="true">→</span>
								</a>
							<?php endforeach; ?>

						</div>

						<?php if (empty($homePrograms)): ?>
							<p>No programs available yet.</p>
						<?php endif; ?>


						<?php if ($showProgramControls): ?>

							<!-- PROGRAM EVENT CONTROLS -->
							<div class="program-event-controls">
								<button type="button" class="program-event-control" id="programPrev" aria-label="Previous program events">←</button>
								<div class="program-event-dots" id="programEventDots" aria-label="Program event pages"></div>
								<button type="button" class="program-event-control" id="programNext" aria-label="Next program events">→</button>
							</div>

						<?php endif; ?>
					</div>


					<!-- QUICK LINKS -->
					<aside class="quick-links" aria-labelledby="quick-links-title">
						<h2 id="quick-links-title">Quick Links</h2>
						<div class="quick-links-grid">

							<?php foreach ($quickLinks as $link): ?>
								<?php if (!empty($link['url']) && !empty($link['featured_image'])): ?>
									<a href="<?= escStudent($link['url']) ?>" class="quick-link-item" target="_blank" rel="noopener noreferrer">
										<img src="image.php?f=<?= rawurlencode($link['featured_image']) ?>" alt="Quick link">
									</a>
								<?php endif; ?>
							<?php endforeach; ?>

							<?php if (empty($quickLinks)): ?>
								<p>No quick links available yet.</p>
							<?php endif; ?>
						</div>
					</aside>
				</div>
			</div>
		</section>



		<!-- CURVE BETWEEN STATS AND FOOTER -->
		<div class="stats-footer-curve" aria-hidden="true">
			<svg viewBox="0 0 1000 100" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg">
				<path fill="#c5df2b" d="M0,45 C250,5 500,5 1000,45 L1000,100 L0,100 Z"/>
				<path fill="#003b29" d="M0,52 C250,12 500,12 1000,52 L1000,100 L0,100 Z"/>
			</svg>
		</div>
	</main>

	<!-- ACADEMIC CALENDAR MODAL -->
	<div class="calendar-modal" id="calendarModal" aria-hidden="true">
		<div class="calendar-modal-backdrop" id="calendarModalBackdrop"></div>
		<div class="calendar-modal-dialog" role="dialog" aria-modal="true" aria-labelledby="calendarModalTitle">

			<div class="calendar-modal-header">
				<h2 id="calendarModalTitle">Academic Calendar</h2>
				<button type="button" class="calendar-modal-close" id="calendarModalClose" aria-label="Close academic calendar">×</button>
			</div>


			<!-- SHOWN WHEN "VIEW FULL CALENDAR" IS CLICKED -->
			<div class="calendar-modal-content">

				<?php foreach ($calendarEvents as $event): ?>
					<article class="calendar-modal-event">

						<div class="calendar-modal-event-info">
							<h3><?= escStudent($event['title']) ?></h3>
							<p><?= escStudent(calendarDateText($event['starts_at'] ?? null, $event['ends_at'] ?? null)) ?></p>
						</div>

						<a href="calendar.php?id=<?= (int)$event['id'] ?>" class="calendar-modal-read-more">Read More <span>→</span></a>
					</article>
				<?php endforeach; ?>

				<?php if (empty($calendarEvents)): ?>
					<div class="calendar-modal-empty">No upcoming events.</div>
				<?php endif; ?>
			</div>

		</div>
	</div>


	<!-- NEWS MODAL -->
	<div class="news-modal" id="newsModal" aria-hidden="true">
		<div class="news-modal-backdrop" id="newsModalBackdrop"></div>
		<div class="news-modal-dialog" role="dialog" aria-modal="true" aria-labelledby="newsModalTitle">
			<div class="news-modal-header">
				<div class="news-modal-heading">
					<span class="news-modal-label" id="newsModalCategory">NEWS</span>
					<h2 id="newsModalTitle"></h2>
				</div>
				<button type="button" class="news-modal-close" id="newsModalClose" aria-label="Close news popup">×</button>
			</div>
			<div class="news-modal-body">
				<figure class="news-modal-image"><img id="newsModalImage" src="" alt=""></figure>
				<div class="news-modal-meta"><span class="news-modal-date" id="newsModalDate">Published</span></div>
				<div class="news-modal-accent"></div>
				<div class="news-modal-placeholder" id="newsModalDescription"></div>
			</div>
			<div class="news-modal-footer">UNIVERSITY OF CALOOCAN CITY <span>•</span> NEWS</div>
		</div>
	</div>


	<?php require_once __DIR__ . '/includes/footer.php'; ?>


	<button class="back-top" id="backTop" aria-label="Back to top">↑</button>

	<script src="https://unpkg.com/lucide@latest"></script>
	<script src="script.js"></script>
	<script>
		window.newsArticles = <?= json_encode($newsArticles, JSON_HEX_TAG | JSON_HEX_AMP | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_UNESCAPED_UNICODE | JSON_INVALID_UTF8_SUBSTITUTE | JSON_FORCE_OBJECT) ?>;
	</script>
	<script src="homepage-modals.js"></script>
	<script>
		document.addEventListener("DOMContentLoaded", function () {
			document.querySelectorAll(".news-section .reveal").forEach(function (element) {
				element.classList.add("show");
			});
			if (window.lucide) {
				window.lucide.createIcons();
			}
		});
	</script>
</body>
</html>