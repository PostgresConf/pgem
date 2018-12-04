class CreatePollResultsView < ActiveRecord::Migration
  def self.up
    execute <<-__EOI
    CREATE EXTENSION tablefunc;

    CREATE VIEW poll_results AS
    SELECT *
      FROM crosstab(
       $$ SELECT question_id, rownum, id
      FROM (SELECT question_id, id,
                   row_number() OVER (PARTITION BY question_id) as rownum
              FROM survey_options) a
     WHERE rownum < 6
       $$
      , 'VALUES (1),(2),(3),(4),(5)'
       )
     AS t (survey_question_id int, answer1 text, answer2 text, answer3 text, answer4 text, answer5 text);


    CREATE INDEX survey_answers_question_option_id_idx ON survey_answers (question_id, option_id);
    __EOI
  end

  def self.down
    execute <<-__EOI
    DROP VIEW poll_results;
    DROP EXTENSION tablefunc;
    DROP INDEX survey_answers_question_option_id_idx;
    __EOI
  end

end
