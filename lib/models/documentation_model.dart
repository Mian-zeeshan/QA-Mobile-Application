class Documentation_Model{
     final String? question;
    final List<String> options;
      Documentation_Model({
            required this.question,required this.options

});
      Map<String, dynamic> toMap() {
            return {
                  'question': this.question,
                  'options' : this.options,
            };
      }

      factory Documentation_Model.fromMap(Map<String, dynamic> map) {
            return Documentation_Model(
                  question: map['question'] ?? "",
                  options: map['options']  ?? "",
            );
      }

}