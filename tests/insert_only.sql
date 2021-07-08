CREATE TABLE "Person" (
    "id" int,
    "name" text,
    "age" int,
    primary key("id")
);

INSERT INTO "Person" VALUES (0, "Harry Potter", 20);
INSERT INTO Person VALUES (1, 'sam', 22);
INSERT INTO `Person` VALUES (2, `Gareth's Bale`, 24);
INSERT INTO person VALUES (3, "Smith, John", 40);
INSERT INTO "PERSON" (id, name, age) VALUES (4, "Too, Many, Commas", 800);
INSERT INTO PERSON (`id`, 'name', "age") VALUES (4, "Too, Many, Commas, Ahhh, No!", 800);