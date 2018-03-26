module ApprovalProcesses
  class Status < EnumerateIt::Base
    associate_values(
      :pendente,
      :aprovado,
      :rejeitado
    )
  end
end
