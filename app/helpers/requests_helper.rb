module RequestsHelper
    def calculation(amounts)
        bill = []
        amounts.each do |amount|
            bill << Item.find(amount.item_id).try(:price) * amount.amount
        end
        bill.sum()
    end

    def count_items(request)
        request.amounts.nil? ? 0 : request.amounts.map(&:amount).sum()
    end

    def find_table(table_id)
        Table.find(table_id).number
    end

    def find_customer(customer_id)
        Customer.find(customer_id).name
    end

    def find_waiter(waiter_id)
        Waiter.find(waiter_id).name
    end
end
