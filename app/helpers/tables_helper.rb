module TablesHelper
    def opened_at(table)
        table.requests.pluck(:created_at).sort().first.strftime("%d%m%Y %I:%M")
    end

    def count_requests(table)
        requests = table.requests
        bill = []
        requests.map(&:amounts).each do |amount|
            amount.each do |requested_item|
                bill << requested_item.amount * Item.find(requested_item.item_id).price
            end
        end
        bill.sum()
    end
end
