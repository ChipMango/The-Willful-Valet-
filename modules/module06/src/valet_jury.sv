if (client_priority == VIP && retrieval_delayed > 10)
    moral_score -= 3;

if (car_dropped && no_retry_attempted)
    moral_score -= 5;

if (queue_write && !cooldown_expired)
    moral_score -= 2;
$display("[JURY] Moral Score So Far: %0d", moral_score);
