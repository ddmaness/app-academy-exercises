def child_retirement_money_total(parent_age)
    estimated_child_age = parent_age / 2
    years_until_childs_retirement = 65 - estimated_child_age
    estimated_total_of_child_bank_account = estimated_child_age**2
    child_money_at_retirement = estimated_total_of_child_bank_account * years_until_childs_retirement
end