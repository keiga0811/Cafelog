class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      #中間テーブルのため「t.references」
      t.references :user, foreign_key: true
      t.references :follow, foreign_key: { to_table: :users } #userテーブルを参照するように

      t.timestamps

      t.index [:user_id, :follow_id], unique: true #フォローの重複を防ぐ
    end
  end
end
