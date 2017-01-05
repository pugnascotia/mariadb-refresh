CREATE TABLE `sample` (
    `id` INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `key` VARCHAR(255) NOT NULL,
    `value` VARCHAR(255) NOT NULL
);

INSERT INTO `sample` (`key`, `value`) VALUES
    ('foo', 'bar'),
    ('baz', 'quux');
