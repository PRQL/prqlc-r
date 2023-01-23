use extendr_api::{list, Attributes, Conversions, IntoRobj};

//wrap result in list
pub fn r_result_list<T, E>(result: std::result::Result<T, E>) -> list::List
where
    T: IntoRobj,
    E: std::fmt::Display,
{
    match result {
        Ok(x) => list!(ok = x.into_robj(), err = extendr_api::NULL),
        Err(x) => list!(ok = extendr_api::NULL, err = x.to_string()),
    }
    .set_class(&["Result"])
    .unwrap()
    .as_list()
    .unwrap()
}
