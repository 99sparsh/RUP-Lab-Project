CREATE TABLE `users` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` varchar(255) NOT NULL,
	`email` varchar(255) NOT NULL UNIQUE,
	`password` varchar(255) NOT NULL,
	`phone` varchar(10) NOT NULL UNIQUE,
	`dob` DATE NOT NULL,
	`prime` BINARY(1) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `hotels` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`address` varchar(255) NOT NULL,
	`city` varchar(20) NOT NULL,
	`pincode` INT(6) NOT NULL,
	`admin_id` INT NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `hotel_admin` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` varchar(255) NOT NULL,
	`email` varchar(255) NOT NULL,
	`password` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `rooms` (
	`id` INT NOT NULL,
	`type` varchar(20) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `room_availability` (
	`hotel_id` INT NOT NULL,
	`room_id` INT NOT NULL,
	`quantity` INT NOT NULL,
	PRIMARY KEY (`hotel_id`,`room_id`)
);

CREATE TABLE `amenities` (
	`hotel_id` INT NOT NULL,
	`room_id` INT NOT NULL,
	`pool` BINARY NOT NULL,
	`room_service` BINARY NOT NULL,
	`housekeeping` BINARY NOT NULL,
	`wifi` BINARY NOT NULL,
	`cab_service` BINARY NOT NULL,
	`parking` BINARY NOT NULL,
	`banquet` BINARY NOT NULL,
	`AC` BINARY NOT NULL,
	`geyser` BINARY NOT NULL,
	`mini_bar` BINARY NOT NULL,
	`spa` BINARY NOT NULL,
	`gym` BINARY NOT NULL,
	`recreation_center` BINARY NOT NULL,
	PRIMARY KEY (`hotel_id`,`room_id`)
);

CREATE TABLE `bookings` (
	`user_id` INT NOT NULL,
	`hotel_id` INT NOT NULL,
	`room_id` INT NOT NULL,
	`checkin` DATE NOT NULL,
	`checkout` DATE NOT NULL,
	`bill_amount` INT NOT NULL,
	PRIMARY KEY (`user_id`,`hotel_id`,`room_id`,`checkin`,`checkout`)
);

CREATE TABLE `pricing` (
	`price` INT NOT NULL,
	`hotel_id` INT NOT NULL,
	`room_id` INT NOT NULL,
	PRIMARY KEY (`hotel_id`,`room_id`)
);

CREATE TABLE `reviews` (
	`user_id` INT NOT NULL,
	`hotel_id` INT NOT NULL,
	`review` TEXT NOT NULL,
	`rating` INT NOT NULL DEFAULT '1',
	PRIMARY KEY (`user_id`,`hotel_id`)
);

ALTER TABLE `hotels` ADD CONSTRAINT `hotels_fk0` FOREIGN KEY (`admin_id`) REFERENCES `hotel_admin`(`id`);

ALTER TABLE `room_availability` ADD CONSTRAINT `room_availability_fk0` FOREIGN KEY (`hotel_id`) REFERENCES `hotels`(`id`);

ALTER TABLE `room_availability` ADD CONSTRAINT `room_availability_fk1` FOREIGN KEY (`room_id`) REFERENCES `rooms`(`id`);

ALTER TABLE `amenities` ADD CONSTRAINT `amenities_fk0` FOREIGN KEY (`hotel_id`) REFERENCES `hotels`(`id`);

ALTER TABLE `amenities` ADD CONSTRAINT `amenities_fk1` FOREIGN KEY (`room_id`) REFERENCES `rooms`(`id`);

ALTER TABLE `bookings` ADD CONSTRAINT `bookings_fk0` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`);

ALTER TABLE `bookings` ADD CONSTRAINT `bookings_fk1` FOREIGN KEY (`hotel_id`) REFERENCES `hotels`(`id`);

ALTER TABLE `bookings` ADD CONSTRAINT `bookings_fk2` FOREIGN KEY (`room_id`) REFERENCES `rooms`(`id`);

ALTER TABLE `pricing` ADD CONSTRAINT `pricing_fk0` FOREIGN KEY (`hotel_id`) REFERENCES `hotels`(`id`);

ALTER TABLE `pricing` ADD CONSTRAINT `pricing_fk1` FOREIGN KEY (`room_id`) REFERENCES `rooms`(`id`);

ALTER TABLE `reviews` ADD CONSTRAINT `reviews_fk0` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`);

ALTER TABLE `reviews` ADD CONSTRAINT `reviews_fk1` FOREIGN KEY (`hotel_id`) REFERENCES `hotels`(`id`);

